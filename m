Message-ID: <448D6FF2.7060004@redhat.com>
Date: Mon, 12 Jun 2006 09:45:22 -0400
From: Chuck Mead <csm@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: permissions on /proc/self/attrib/current
References: <4485C100.4030805@redhat.com> <1150119045.8086.17.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1150119045.8086.17.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060501010003020403070502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060501010003020403070502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2006-06-06 at 13:53 -0400, Chuck Mead wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> The file /proc/self/attrib/current is world read and write. Is this
>> correct? Why does it need world read and write?
> 
> To completely disable DAC restrictions, and leave it entirely to SELinux
> to control access.  The corresponding hook functions in the SELinux
> "module", selinux_getprocattr and selinux_setprocattr, apply permission
> checks on reading and writing these nodes, and selinux_setprocattr
> further prohibits a task from setting (writing) attributes other than
> its own.
> 
> The DAC restrictions can be problematic when the task becomes
> undumpable, e.g. setuid or setgid programs could otherwise lose access
> to their own /proc/pid/attr nodes.

If selinux is disabled is this file still present?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEjW/xZfy0juH51WsRAtwCAJ0bFY7+YKxe7sr9WgQCvx8VY4okcgCgkVT/
EVDRmiSlQ48BC0s3EdkpvNo=
=44pn
-----END PGP SIGNATURE-----

--------------060501010003020403070502
Content-Type: text/x-vcard; charset=utf-8;
 name="csm.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="csm.vcf"

begin:vcard
fn:Chuck Mead
n:Mead;Chuck
org:Red Hat, Inc.;GPS,
adr:;;1801 Varsity Drive;Raleigh;NC;27606;USA
email;internet:csm@redhat.com
title:Consultant
tel;cell:919-621-0605
note;quoted-printable:You can have peace. Or you can have freedom. Don=E2=80=99t ever count onh=
	aving both at once. - Lazarus Long
x-mozilla-html:FALSE
url:http://redhat.com
version:2.1
end:vcard


--------------060501010003020403070502--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
