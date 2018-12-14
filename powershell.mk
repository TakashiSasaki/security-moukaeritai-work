POWERSHELL=/drives/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe
.PHONY: ${CERTS}
PFXPASS=hogehogehoge
CERTS= \
	Cert\
	Cert-LocalMachine\
	Cert-LocalMachine-TestSignRoot\
	Cert-LocalMachine-ClientAuthIssuer\
	Cert-LocalMachine-Remote_Desktop\
	Cert-LocalMachine-Root\
	Cert-LocalMachine-Windows_Web_Management\
	Cert-LocalMachine-TrustedDevices\
	Cert-LocalMachine-MSIEHistoryJournal\
	Cert-LocalMachine-CA\
	Cert-LocalMachine-Recovery\
	Cert-LocalMachine-eSIM_Certification_Autorities\
	Cert-LocalMachine-AuthRoot\
	Cert-LocalMachine-Windows_Live_ID_Token_Issuer\
	Cert-LocalMachine-TrustedPublisher\
	Cert-LocalMachine-AAD_Token_Issuer\
	Cert-LocalMachine-FlightRoot\
	Cert-LocalMachine-TrustedPeople \
	Cert-LocalMachine-AddressBook\
	Cert-LocalMachine-Local_NonRemovable_Certificates\
	Cert-LocalMachine-My \
	Cert-LocalMachine-SmartCardRoot \
	Cert-LocalMachine-Trust \
	Cert-LocalMachine-Homegroup_Machine_Certificates \
	Cert-CurrentUser \
	Cert-CurrentUser-TrustedPublisher \
	Cert-CurrentUser-ClientAuthIssuer \
	Cert-CurrentUser-Root \
	Cert-CurrentUser-UserDS \
	Cert-CurrentUser-CA \
	Cert-CurrentUser-REQUEST\
	Cert-CurrentUser-AuthRoot \
	Cert-CurrentUser-MSIEHistoryJournal \
	Cert-CurrentUser-TrustedPeople\
	Cert-CurrentUser-AddressBook\
	Cert-CurrentUser-Local_NonRemovable_Certificates\
	Cert-CurrentUser-My \
	Cert-CurrentUser-SmartCardRoot \
	Cert-CurrentUser-Trust 

certs: ${CERTS}

clean::
	-rm -f *.items
	-rm -f Cert-*
	-rm -f *.ps1

define make_ps1
	${POWERSHELL} -Command Get-ChildItem $1 >$@
	echo '$$pw = ConvertTo-SecureString -String ${PFXPASS} -Force -AsPlainText' >> $@.ps1
	echo "cd $1" >> $@.ps1
	sed -n -r 's/^([0-9a-fA-F]{40}) .*/Export-PfxCertificate -Cert \1 -FilePath \1.pfx -Password $$pw/p' $@ >>$@.ps1
	${POWERSHELL} -File $2.ps1
endef


Cert:
	${POWERSHELL} -Command Get-ChildItem \'Cert:\' >$@

Cert-LocalMachine:
	${POWERSHELL} -Command Get-ChildItem \'Cert:\\LocalMachine\' >$@

Cert-LocalMachine-TestSignRoot.path=\"Cert:\\LocalMachine\\TestSignRoot\" 
Cert-LocalMachine-TestSignRoot:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-ClientAuthIssuer.path=\"Cert:\\LocalMachine\\ClientAuthIssuer\"
Cert-LocalMachine-ClientAuthIssuer:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-Remote_Desktop.path=\"Cert:\\LocalMachine\\Remote Desktop\"
Cert-LocalMachine-Remote_Desktop:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-Root.path=\"Cert:\\LocalMachine\\Root\"
Cert-LocalMachine-Root:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-Windows_Web_Management.path=\"Cert:\\LocalMachine\\Windows Web Management\"
Cert-LocalMachine-Windows_Web_Management:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-TrustedDevices.path=\"Cert:\\LocalMachine\\TrustedDevices\"
Cert-LocalMachine-TrustedDevices:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-MSIEHistoryJournal.path=\"Cert:\\LocalMachine\\MSIEHistoryJournal\"
Cert-LocalMachine-MSIEHistoryJournal:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-CA.path=\"Cert:\\LocalMachine\\CA\"
Cert-LocalMachine-CA:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-Recovery.path=\"Cert:\\LocalMachine\\Recovery\"
Cert-LocalMachine-Recovery:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-eSIM_Certification_Autorities.path=\"Cert:\\LocalMachine\\eSIM Certification Authorities\"
Cert-LocalMachine-eSIM_Certification_Autorities:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-AuthRoot.path=\"Cert:\\LocalMachine\\AuthRoot\"
Cert-LocalMachine-AuthRoot:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-Windows_Live_ID_Token_Issuer.path=\"Cert:\\LocalMachine\\Windows Live ID Token Issuer\"
Cert-LocalMachine-Windows_Live_ID_Token_Issuer:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-TrustedPublisher.path=\"Cert:\\LocalMachine\\TrustedPublisher\"
Cert-LocalMachine-TrustedPublisher:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-AAD_Token_Issuer.path=\"Cert:\\LocalMachine\\AAD Token Issuer\"
Cert-LocalMachine-AAD_Token_Issuer:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-FlightRoot.path=\"Cert:\\LocalMachine\\FlightRoot\"
Cert-LocalMachine-FlightRoot:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-TrustedPeople.path=\"Cert:\\LocalMachine\\TrustedPeople\"
Cert-LocalMachine-TrustedPeople:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-Local_NonRemovable_Certificates.path=\"Cert:\\LocalMachine\\Local NonRemovable Certificates\"
Cert-LocalMachine-Local_NonRemovable_Certificates:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-My.path=\"Cert:\\LocalMachine\\My\"
Cert-LocalMachine-My:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-SmartCardRoot.path=\"Cert:\\LocalMachine\\SmartCardRoot\"
Cert-LocalMachine-SmartCardRoot:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-Trust.path=\"Cert:\\LocalMachine\\Trust\"
Cert-LocalMachine-Trust:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-Homegroup_Machine_Certificates.path=\"Cert:\\LocalMachine\\Homegroup Machine Certificates\"
Cert-LocalMachine-Homegroup_Machine_Certificates:
	$(call make_ps1,${$@.path},$@)

Cert-LocalMachine-AddressBook.path=\"Cert:\\LocalMachine\\AddressBook\"
Cert-LocalMachine-AddressBook:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser:
	${POWERSHELL} -Command Get-ChildItem \"Cert:\CurrentUser\" >$@

Cert-CurrentUser-TrustedPublisher.path=\"Cert:\\CurrentUser\\TrustedPublisher\"
Cert-CurrentUser-TrustedPublisher:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-ClientAuthIssuer.path=\"Cert:\\CurrentUser\\ClientAuthIssuer\"
Cert-CurrentUser-ClientAuthIssuer:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-Root.path=\"Cert:\\CurrentUser\\Root\"
Cert-CurrentUser-Root:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-UserDS.path=\"Cert:\\CurrentUser\\UserDS\"
Cert-CurrentUser-UserDS:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-CA.path=\"Cert:\\CurrentUser\\CA\"
Cert-CurrentUser-CA:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-REQUEST.path=\"Cert:\\CurrentUser\\REQUEST\"
Cert-CurrentUser-REQUEST:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-AuthRoot.path=\"Cert:\\CurrentUser\\AuthRoot\"
Cert-CurrentUser-AuthRoot:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-MSIEHistoryJournal.path=\"Cert:\\CurrentUser\\MSIEHistoryJournal\"
Cert-CurrentUser-MSIEHistoryJournal:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-TrustedPeople.path=\"Cert:\\CurrentUser\\TrustedPeople\"
Cert-CurrentUser-TrustedPeople:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-AddressBook.path=\"Cert:\\CurrentUser\\AddressBook\"
Cert-CurrentUser-AddressBook:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-Local_NonRemovable_Certificates.path=\"Cert:\\CurrentUser\\Local NonRemovable Certificates\"
Cert-CurrentUser-Local_NonRemovable_Certificates:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-My.path=\"Cert:\\CurrentUser\\My\"
Cert-CurrentUser-My:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-SmartCardRoot.path=\"Cert:\\CurrentUser\\SmartCardRoot\"
Cert-CurrentUser-SmartCardRoot:
	$(call make_ps1,${$@.path},$@)

Cert-CurrentUser-Trust.path=\"Cert:\\CurrentUser\\Trust\"
Cert-CurrentUser-Trust:
	$(call make_ps1,${$@.path},$@)

