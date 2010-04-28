Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SFYlke018043
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 11:34:47 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SFZlMk024188
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 15:35:48 GMT
Message-ID: <4BD85592.40003@redhat.com>
Date: Wed, 28 Apr 2010 11:34:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
References: <4BCC69C0.5040502@redhat.com>	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>	 <4BCF05D3.5090700@redhat.com>	 <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>	 <4BD0513C.40403@redhat.com>	 <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com>	 <w2q10143821004221216j96faf709w8b702c67835197d6@mail.gmail.com>	 <4BD1B843.1030805@redhat.com> <n2g10143821004280725qcf3ebaf8n44eb53504aa32feb@mail.gmail.com>
In-Reply-To: <n2g10143821004280725qcf3ebaf8n44eb53504aa32feb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/28/2010 10:25 AM, Karl MacMillan wrote:


I understand, although I don't agree with penalizying because you match
on an attribute,   Currently if I wrote this interface the way I want,
with just the attribute your algorithm would not find it at all.

files_read_etc_files to me means match all config files in the /etc
directory, just because some random application decides to change the
context of /etc/hostname to etc_runtime_t or net_conf_t, we should not
need to change all domains that are supposed to read generic files in
/etc.  Especially when I don't even need to read them.


I would argue that

allow X etc_t:file read;
allow X configfile:file read;

Should be weighted equivalently if etc_t is a configfile or only
slightly heavier, and just because etc_runtime_t or some other random
types are configfile does not mean we need to add weight.

But when the attribute adds more weight then "write" does, I think the
algorithm is broken.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvYVY4ACgkQrlYvE4MpobOKSgCgguxc5xhYFpW1GGSnN4N+6v/Z
qUsAoOjz7qSp8kiDHBUN2SYoKWsZfTNK
=Ubgb
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
