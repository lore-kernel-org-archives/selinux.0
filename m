Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mALJKOVt027264
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 14:20:24 -0500
Received: from gv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mALJKNMA004003
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 19:20:24 GMT
Received: by gv-out-0910.google.com with SMTP id i36so296567gve.17
        for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2008 11:20:23 -0800 (PST)
Message-ID: <492709F5.2090801@gmail.com>
Date: Fri, 21 Nov 2008 20:20:21 +0100
From: Vince Le Port <vince.rafale@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Context transition error
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear all,

I am working on a mean to change the nfs server context depending on the
user who wants to access his files. I have planned to use MCS to do that.

Here is the approach for NFS:

Let us say, we have two users : client1 in s0:c1 and client2 in s0:c2
If client1 wants to access his home directory mounted with NFS, then the
NFS daemon will change his MCS category corresponding to the client MCS
category
That will limit the risk that client2 could access client1's files

Thus, for example my test program is launched in that context :
sysadm_u:sysadm_r:sysadm_t:s0:c1.c2

Then that program makes a setcon in order to move into
sysadm_u:sysadm_r:sysadm_t:s0:c1 and the following step is to move the
program in that context sysadm_u:sysadm_r:sysadm_t:s0:c2

I have written the following semodule :

module localadmin 1.0;

require {
        type sysadm_t;
        class process setcurrent;
        class process dyntransition;
}

allow sysadm_t self:process { setcurrent dyntransition };

The problem is that this setcon does not work. Audit launches a
dyntransition permission denied :

type=AVC msg=audit(1224660818.891:422): avc: denied { dyntransition }
for pid=18334 comm="prog" scontext=sysadm_u:sysadm_r:sysadm_t:s0:c2
tcontext=sysadm_u:sysadm_r:sysadm_t:s0:c1 tclass=process

It also seems impossible to return back to the original context s0:c1.c2
, once s0:c1 is reached

Is it possible to allow this transition?

Thanks you for helping a SElinux newbie

Regards,

Vince
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJJwn1CkDrToteDh0RAgtMAKC4N4YG9+VIB2u0NtEwYbpSXgvqzACdFc8u
1YhQzdQDTLNfq8hT1Kh0NZY=
=zYx5
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
