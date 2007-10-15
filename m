Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9F3kBIa015973
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 23:46:11 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9F3kA6q008762
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 03:46:10 GMT
In-Reply-To: <Xine.LNX.4.64.0710151116270.433@us.intercode.com.au>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>  <1191949852.23486.55.camel@dhcp-64-223.iad.redhat.com>  <1191956082.2794.107.camel@moss-lions.epoch.ncsc.mil>  <1191956863.23486.62.camel@dhcp-64-223.iad.redhat.com>  <1191959097.2794.127.camel@moss-lions.epoch.ncsc.mil>  <1191960025.23486.70.camel@dhcp-64-223.iad.redhat.com>  <1192029823.2898.32.camel@localhost.localdomain>  <1192035162.15060.57.camel@moss-lions.epoch.ncsc.mil>  <1192048777.7524.9.camel@localhost.localdomain> <1192122040.26928.61.camel@dhcp-64-223.iad.redhat.com> <Xine.LNX.4.64.0710151116270.433@us.intercode.com.au>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-9--635651122; protocol="application/pkcs7-signature"
Message-Id: <A0FDC039-0AE8-4924-BCAE-263788304936@nall.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, jwcart2@tycho.nsa.gov,
        SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
From: Joe Nall <joe@nall.com>
Subject: Re: Are the reference policy abstractions the right ones?
Date: Sun, 14 Oct 2007 22:45:12 -0500
To: James Morris <jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-9--635651122
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Oct 14, 2007, at 9:50 PM, James Morris wrote:

> On Thu, 11 Oct 2007, Karl MacMillan wrote:
>
>> So - I'd like to hear from some other people. Are these ideas worth
>> pursuing? The proposals:
>>
>> 1) remove the distinction between attributes / types.
>> 2) allow nested types / attributes.
>> 3) type_class / type_group
>> 4) exceptions
>
> I think moving to a general OO model at a higher level is  
> desirable, and
> that we need to go beyond simply 'type' in #3 and look at OO  
> classes which
> encapsulate all SELinux-related attributes (permissions, labeling  
> rules,
> network policy, booleans etc).
>
> People are increasingly utilizing containers/VMs/appliances to  
> manage and
> isolate their applications, and I think that this is also a means  
> for us
> to provide higher-level SELinux abstractions.
>
> With comprehensive SELinux classes, we could:
>
> - Bind security classes to various levels of system abstraction,  
> and thus
>   bind security objects to a variety of types of encapsulating objects
>   (e.g. RPM, VM, container, tarball, standalone file);
>
> - Modify classes via inheritance (already discussed somewhat);
>
> - Define high-level interactions between classes via well-defined
>   interfaces;
>
> - Compose classes into higher-level classes in a structured,  
> analyzable
>   manner.
>
> With the latter being an important way to allow admins to configure
> overall security at a meaningful level of granularity, matching the  
> level
> of encapsulation which they are already using for managing  
> applications.
>
> The idea generally being that admins/developers not think in terms  
> of low
> level policy constructs (although allow these to be exposed if  
> needed),
> but rather, to think about composing security objects into e.g. a
> container, and then from a system point of view, to be able to broadly
> define how the containers interact with each other and the base  
> system.
>
>
> Thoughts?

Brooks Second System Syndrome

joe


--Apple-Mail-9--635651122
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIIqzCCBDIw
ggMaoAMCAQICAR0wDQYJKoZIhvcNAQEFBQAwWzELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4g
R292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxFjAUBgNVBAMTDURvRCBSb290
IENBIDIwHhcNMDYwNjE0MTcwNDAzWhcNMTIwNjE0MTYwNDAzWjBdMQswCQYDVQQGEwJVUzEYMBYG
A1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UE
AxMPRE9EIEVNQUlMIENBLTE2MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDhLwdkjsbyObA
y1xFSIN58Ffu5Uvt8Fvnf/2kW27pjGkSnkoOH0Y0/xJFJcS5bDDb//kz3eojDlhn906fVccBuoZ7
mWLptyXcPRIfFDzdykorWcdHn8+EKSD80ylXnsjxVPpFm6qio9GvHFK8ceMXGbnXBDlrDZMiICQl
m84kTwIDAQABo4IBgTCCAX0wDgYDVR0PAQH/BAQDAgGGMB8GA1UdIwQYMBaAFEl0uwxeunr+AlTv
e6DGlcYJgHCWMB0GA1UdDgQWBBRHk8ejIzy0Me7MQnzdaBPLAZqPLTAMBgNVHSQEBTADgAEAMA8G
A1UdEwEB/wQFMAMBAf8wMAYDVR0gBCkwJzALBglghkgBZQIBCwUwCwYJYIZIAWUCAQsJMAsGCWCG
SAFlAgELCjCB2QYDVR0fBIHRMIHOMDigNqA0hjJodHRwOi8vY3JsLmdkcy5kaXNhLm1pbC9nZXRj
cmw/RG9EJTIwUm9vdCUyMENBJTIwMjCBkaCBjqCBi4aBiGxkYXA6Ly9jcmwuZ2RzLmRpc2EubWls
L2NuJTNkRG9EJTIwUm9vdCUyMENBJTIwMiUyY291JTNkUEtJJTJjb3UlM2REb0QlMmNvJTNkVS5T
LiUyMEdvdmVybm1lbnQlMmNjJTNkVVM/Y2VydGlmaWNhdGVyZXZvY2F0aW9ubGlzdDtiaW5hcnkw
DQYJKoZIhvcNAQEFBQADggEBAAZhhKwoETryrmbMiJj6Tr6XxadbI42CLQEnkTDqxiLJVzQ6h/n4
Blv6Zm2xie3Tm0NigASlKlNoWNRrVojLahSiTn10G2c6iwe1LOSgICe/SGfo8+nJaZ9/AUhh+8En
d3uPvq7SQtEMMSQmndcakfONrP5vky3gHk/HOQR/cR8up8nnP+hx3iq30KwRC27qizWjdZU9rmcI
F92GGPpIkhsALmEXqWxURGlJIBctWQqbAepDRKDnV9JUhBcT400kANiueiDX40qPN8R/vLGhgyF+
c3E3aJHbReL/2BrtEGBauWHMwAA8pW3MuZz+xp3HGp7AcE2CwTn4hsrBoA/Q+ekwggRxMIID2qAD
AgECAgMJCIswDQYJKoZIhvcNAQEFBQAwXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292
ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBD
QS0xNjAeFw0wNzA1MjEwMDAwMDBaFw0wOTAxMzEyMzU5NTlaMHsxCzAJBgNVBAYTAlVTMRgwFgYD
VQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRMwEQYDVQQL
EwpDT05UUkFDVE9SMSEwHwYDVQQDExhOQUxMLkpPU0VQSC5ELjEyNjUwODIwNTYwgZ8wDQYJKoZI
hvcNAQEBBQADgY0AMIGJAoGBAIQaYg7wCON3AccvTUkzRHFGkA7lrHchWPxvsIhLwXvku/a0ltwk
eQJMomHL/3GQQ/Y3eEPTklFQyGoJkx6uaQu6v6eOlWqzf4RnOpoR57LHZpE50evy0RnZfEepSRzW
K4uL5tp0k/sTcuESdyt7g4hhob1DBdOntehdBcRm3Hl3AgMBAAGjggIfMIICGzAOBgNVHQ8BAf8E
BAMCBsAwHwYDVR0jBBgwFoAUR5PHoyM8tDHuzEJ83WgTywGajy0wHQYDVR0OBBYEFB+HBoRJ6sDm
KYkyzdyMq1dRO3ZWMBYGA1UdIAQPMA0wCwYJYIZIAWUCAQsJMIHZBgNVHR8EgdEwgc4wOKA2oDSG
Mmh0dHA6Ly9jcmwuZ2RzLmRpc2EubWlsL2dldGNybD9ET0QlMjBFTUFJTCUyMENBLTE2MIGRoIGO
oIGLhoGIbGRhcDovL2NybC5nZHMuZGlzYS5taWwvY24lM2RET0QlMjBFTUFJTCUyMENBLTE2JTJj
b3UlM2RQS0klMmNvdSUzZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2MlM2RVUz9jZXJ0
aWZpY2F0ZVJldm9jYXRpb25MaXN0O2JpbmFyeTApBgNVHSUEIjAgBgorBgEEAYI3FAICBggrBgEF
BQcDBAYIKwYBBQUHAwIwNwYDVR0RBDAwLoEMam9lQG5hbGwuY29toB4GCisGAQQBgjcUAgOgEAwO
MTI2NTA4MjA1NkBtaWwwcQYIKwYBBQUHAQEEZTBjMD8GCCsGAQUFBzAChjNodHRwOi8vY3JsLmdk
cy5kaXNhLm1pbC9nZXRzaWduP0RPRCUyMEVNQUlMJTIwQ0EtMTYwIAYIKwYBBQUHMAGGFGh0dHA6
Ly9vY3NwLmRpc2EubWlsMA0GCSqGSIb3DQEBBQUAA4GBAGyIAqWQ5N0DQL4HRnIZsZohhrq//qdz
XLVCRjLMQuWIGzuZheD6fvksx+dcDdPu8vcJLUUis2Kp8cGATA3dmXWI018hv534HvJnKtHvizpe
PIxHmZAacVhBV//BBJU8h3E2lKRkUuyKtAYgpXWy73UhcUoIKAPmGFgpKGQNJVSJMYICVzCCAlMC
AQEwZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNE
b0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTE2AgMJCIswCQYFKw4DAhoF
AKCCAUkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDcxMDE1MDM0
NTEzWjAjBgkqhkiG9w0BCQQxFgQUdT7AUpWxPsc6JR+N40os1F8BvMcwcwYJKwYBBAGCNxAEMWYw
ZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0Qx
DDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTE2AgMJCIswdQYLKoZIhvcNAQkQ
AgsxZqBkMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsT
A0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMTYCAwkIizANBgkqhkiG
9w0BAQEFAASBgBh4B63hAgBMGYdTvkf8g8bGm6Qi6Ort/oUIPIAJAes8oX7CqPLspMosCZvzTVp0
ui8wvUi3KyhElXQcGRta+0Zt5x2auwwE/gpZ0SMci4e9zoIN86AgM8Hc9ZBi6/BDt7VPRaPNP7n1
r8RKLf4kpn25ZUJWNa8hxcuI2BFV3yMTAAAAAAAA

--Apple-Mail-9--635651122--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
