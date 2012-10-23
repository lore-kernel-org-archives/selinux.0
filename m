Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9NJSLv2017630
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 15:28:21 -0400
Received: from LLE2K7-HUB02.mitll.ad.local (LLE2K7-HUB02.mitll.ad.local) by mx2.ll.mit.edu (unknown) with ESMTP id q9NJSJL4003232 for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 15:28:19 -0400
From: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 23 Oct 2012 15:28:16 -0400
Subject: Question about policy module error message
Message-ID: <CCAC6810.2205%thomas.moyer@ll.mit.edu>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="B_3433850896_72386686"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--B_3433850896_72386686
Content-type: multipart/alternative;
	boundary="B_3433850896_72355861"


--B_3433850896_72355861
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit

I am trying to build an SELinux policy module for a piece of software I am
writing. I used sepolgen to create an initial skeleton policy (running on
Red Hat Enterprise Linux 6). I get the following error when I try and
install the policy:

sudo ./interface.sh
Building and Loading Policy
+ make -f /usr/share/selinux/devel/Makefile
make: Nothing to be done for `all'.
+ /usr/sbin/semodule -i interface.pp
libsemanage.semanage_fc_sort: WARNING: semanage_fc_sort: Incomplete context.
libsepol.sepol_context_from_string: malformed context "dnl"
libsepol.sepol_context_from_string: could not construct context from string
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert dnl to sid
invalid context dnl
libsemanage.semanage_install_active: setfiles returned error code 1.
/usr/sbin/semodule:  Failed!

Below is the interface.fc file since I think the error might be in there.
/usr/local/bin/interface --
gen_context(system_u:object_r:interface_exec_t,s0)
/usr/local/libexec/interface gen_context(system_u:object_r:usr_t,s0)
/usr/local/libexec/interface/WebApp.jar --
gen_context(system_u:object_r:httpd_sys_content_t,s0)
/usr/local/libexec/interface/keystore --
gen_context(system_u:object_r:interfaceKey_t,s0)
/usr/local/libexec/interface/ui-files(/.*)?
gen_context(system_u:object_r:httpd_sys_content_t,s0)

Not sure how to go about debugging this.

Thanks for the help.

-Tom

-- 
Thomas Moyer, Technical Staff voice: (781) 981-1374
Cyber Systems Technology Group mobile: (857) 268-0493
MIT Lincoln Laboratory email: thomas.moyer@ll.mit.edu
244 Wood Street
Lexington, MA 02420



--B_3433850896_72355861
Content-type: text/html;
	charset="US-ASCII"
Content-transfer-encoding: quoted-printable

<html><head></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space; color: rgb(0, 0, 0); font-size:=
 14px; font-family: Calibri, sans-serif; "><div><div><div>I am trying to bui=
ld an SELinux policy module for a piece of software I am writing. I used sep=
olgen to create an initial skeleton policy (running on Red Hat Enterprise Li=
nux 6). I get the following error when I try and install the policy:</div><d=
iv><br></div><div><div>sudo ./interface.sh</div><div>Building and Loading Po=
licy</div><div>+ make -f /usr/share/selinux/devel/Makefile</div><div>make: N=
othing to be done for `all'.</div><div>+ /usr/sbin/semodule -i interface.pp<=
/div><div>libsemanage.semanage_fc_sort: WARNING: semanage_fc_sort: Incomplet=
e context.</div><div>libsepol.sepol_context_from_string: malformed context "=
dnl"</div><div>libsepol.sepol_context_from_string: could not construct conte=
xt from string</div><div>libsepol.context_from_string: could not create cont=
ext structure</div><div>libsepol.sepol_context_to_sid: could not convert dnl=
 to sid</div><div>invalid context dnl</div><div>libsemanage.semanage_install=
_active: setfiles returned error code 1.</div><div>/usr/sbin/semodule: &nbsp=
;Failed!</div></div><div><br></div><div>Below is the interface.fc file since=
 I think the error might be in there.</div><div><div>/usr/local/bin/interfac=
e<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>--<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>gen_context(system_u:objec=
t_r:interface_exec_t,s0)</div><div>/usr/local/libexec/interface<span class=3D"=
Apple-tab-span" style=3D"white-space:pre">				</span>gen_context(system_u:obje=
ct_r:usr_t,s0)</div><div>/usr/local/libexec/interface/WebApp.jar<span class=3D=
"Apple-tab-span" style=3D"white-space:pre">	</span>--<span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">	</span>gen_context(system_u:object_r:httpd_sys_=
content_t,s0)</div><div>/usr/local/libexec/interface/keystore<span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">	</span>--<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>gen_context(system_u:object_r:interfaceKey_=
t,s0)</div><div>/usr/local/libexec/interface/ui-files(/.*)?<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">		</span>gen_context(system_u:object_r:h=
ttpd_sys_content_t,s0)</div></div><div><br></div><div>Not sure how to go abo=
ut debugging this.</div><div><br></div><div>Thanks for the help.</div><div><=
br></div><div>-Tom</div><div><br></div><div><div><div>--&nbsp;</div><div><di=
v><div>Thomas Moyer, Technical Staff<span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">		</span>voice: (781) 981-1374</div><div>Cyber Systems Technolo=
gy Group<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>mobile=
: (857) 268-0493</div><div>MIT Lincoln Laboratory<span class=3D"Apple-tab-span=
" style=3D"white-space:pre">				</span>email:&nbsp;<a href=3D"mailto:thomas.moye=
r@ll.mit.edu">thomas.moyer@ll.mit.edu</a></div><div>244 Wood Street</div><di=
v>Lexington, MA 02420</div></div></div></div></div></div></div></body></html=
>

--B_3433850896_72355861--

--B_3433850896_72386686
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIUEgYJKoZIhvcNAQcCoIIUAzCCE/8CAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
EfUwggTUMIIDvKADAgECAgpbnpTCAAAAAE9nMA0GCSqGSIb3DQEBCwUAMFExCzAJBgNVBAYT
AlVTMR8wHQYDVQQKExZNSVQgTGluY29sbiBMYWJvcmF0b3J5MQwwCgYDVQQLEwNQS0kxEzAR
BgNVBAMTCk1JVExMIENBLTIwHhcNMTIwODI0MTMzNzMyWhcNMTMwODI0MTMzNzMyWjBhMQsw
CQYDVQQGEwJVUzEfMB0GA1UEChMWTUlUIExpbmNvbG4gTGFib3JhdG9yeTEPMA0GA1UECxMG
UGVvcGxlMSAwHgYDVQQDExdNb3llci5UaG9tYXMuTS41MDAxMjcxNTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAN2kzL21gle2n6FJ68b7s6rhJUZWK4zTnKN9TD7tGS1mLNuD
kO55g8tKHf8g+TM5nK89anV960D+4cwbWK4sbs9pQcrrSlzhQJhsZ4QSqMWsT9Gzq2qucaSw
Tge3LuySmA/8JPbVa3c+sSQNYc6qkbGKg97WYA+CP/CKknN8yS14S2OX1W27GJsTzF4c84Ya
B1qRBAwfBQMFbd51AfZ5j0c6isk0ov8kJkyYrqHKj4qbOG8WjvmSkPA+pXcbwUEnWXJLtCZZ
4+aZIQ2Sv7DE35urlrzYjrY6ENUzDV5dy86oFKjf8nJFiIV6NtYVSkRVOK2e5KqsGpIdcAOp
TJus/y8CAwEAAaOCAZwwggGYMB0GA1UdDgQWBBQVe66M3+xu+px9yukwqwj+SAbDUTAOBgNV
HQ8BAf8EBAMCBsAwHwYDVR0jBBgwFoAUjkp9iaFjFxyBiDRXNyZFXhmKfiQwMwYDVR0fBCww
KjAooCagJIYiaHR0cDovL2NybC5sbC5taXQuZWR1L2dldGNybC9MTENBMjBiBggrBgEFBQcB
AQRWMFQwLQYIKwYBBQUHMAKGIWh0dHA6Ly9jcmwubGwubWl0LmVkdS9nZXR0by9MTENBMjAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3AubGwubWl0LmVkdS8wDAYDVR0TAQH/BAIwADA9Bgkr
BgEEAYI3FQcEMDAuBiYrBgEEAYI3FQiDg+Udh+ynZoathxWD6vBFhbahHx2Fy94yh/+KcwIB
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
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAInOjv4PcQYSwcse3b/iU13ufWpydhGF1zKyWx6V
xn7EhTdIiVqRZSWEEhUN54ZZvcNCjJigjNc92nS7/DZ6QzHTDuWlIvgi76xgl8bbK6oCKEv8
0+LBZKd4w3O8G0D3JakwveWWT1jZJXRG0QT6y9Xy4ENiWleon60UAKD5frJtnNu3AH8ElATk
uh5iPyMzvvZ+dthAeVjyOnYiRTI3/z+8nWrY2Yxd5dumg8YuGP4Xg24lhSzxRFluqflWytRy
jOabskU4bjjW9MTMhLXDR5P1UG1ilkCG1CK883No8b4QguQhMTCPv4/3vta3E2V3m1APGCJf
n9GNXaJTi4/369ECAwEAAaOCAZ8wggGbMB0GA1UdDgQWBBQ/lnMko0FQsFkSo7eGshVplcTt
nDAOBgNVHQ8BAf8EBAMCBSAwHwYDVR0jBBgwFoAUjkp9iaFjFxyBiDRXNyZFXhmKfiQwMwYD
VR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5sbC5taXQuZWR1L2dldGNybC9MTENBMjBiBggr
BgEFBQcBAQRWMFQwLQYIKwYBBQUHMAKGIWh0dHA6Ly9jcmwubGwubWl0LmVkdS9nZXR0by9M
TENBMjAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AubGwubWl0LmVkdS8wDAYDVR0TAQH/BAIw
ADA9BgkrBgEEAYI3FQcEMDAuBiYrBgEEAYI3FQiDg+Udh+ynZoathxWD6vBFhbahHx2F69Bw
g+vtIAIBZAIBBDAlBgNVHSUEHjAcBgRVHSUABggrBgEFBQcDBAYKKwYBBAGCNwoDBDAYBgNV
HSAEETAPMA0GCyqGSIb3EgIBAwEIMCIGA1UdEQQbMBmBF3Rob21hcy5tb3llckBsbC5taXQu
ZWR1MA0GCSqGSIb3DQEBCwUAA4IBAQBwwPS4BoKbBymCVEqjxedOV4E5Fru8DwWklJ3GD7C+
wttuGXTKfy51Jdb2fySXLKSrhXZ0hM4c8gdUpOZN8SShDXFFdHt3pc5k4ZW2JBvkTv3MYDr3
UIJqQMpuKx5S/yZjOgcsIuDHzwa6Wh+YwlEa1eiJJ3KYdqKQiKUht0ogXAJK/UfbUraLTKBr
HYFAzDC5a2bgDjS4yDGfx7M1hWHAXYEqNcXp9MTPhCayleDpFAeBsNdihvFzuQfXJioY3hHl
Tf36w7GE4RMfnEHvrZzVvfZ4kDkN0Eta85cj8Oc/YtYN/j9RaFkZzw+MsygDhUDMPuyBVvdn
P6L1gdK5yCyCMYIB5TCCAeECAQEwXzBRMQswCQYDVQQGEwJVUzEfMB0GA1UEChMWTUlUIExp
bmNvbG4gTGFib3JhdG9yeTEMMAoGA1UECxMDUEtJMRMwEQYDVQQDEwpNSVRMTCBDQS0yAgpb
npTCAAAAAE9nMAkGBSsOAwIaBQCgXTAjBgkqhkiG9w0BCQQxFgQU2ABBFnPUGuLjzPf5dkxq
Ltz5rEMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTIxMDIz
MTkyODE2WjANBgkqhkiG9w0BAQEFAASCAQAJtt7pY1V9lqtS+j9joq9Eff5aCTAVKVCxF0xK
+uFUa/rTV7D247bV5q+YMUMJ0fHU2UqHufVXrtoJomMQag3YKb2OV2vjUzDNhGspt/XHUqn6
fT7WDEbh813nIxXquvbb951s2dBmbgusOBIrzj9YIpfFFlSbnZ0QqWE2KhJZfNmptWqqmNAG
Ja6+mPV+zAYvxi7v+qmF35G8/arULjiEsR+4/vjBoiXvfCLCwoHARXjI1MMBTjZWgaNs3gj8
ZlLhGVQ3RLNKDy4n7qCat0SQ8h7CM9hA+MBl9oANYfEb793SfgYJbHh/fO999Tzymt7qvjFH
z+RyIvLicXa/Bb5m

--B_3433850896_72386686--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
