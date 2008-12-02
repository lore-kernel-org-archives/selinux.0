Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB2Eg8cW023437
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2008 09:42:08 -0500
Received: from gv-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB2Ee21k006817
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2008 14:40:02 GMT
Received: by gv-out-0910.google.com with SMTP id i36so559681gve.17
        for <selinux@tycho.nsa.gov>; Tue, 02 Dec 2008 06:42:06 -0800 (PST)
Message-ID: <4935493A.8020301@gmail.com>
Date: Tue, 02 Dec 2008 15:42:02 +0100
From: Vince Le Port <vince.rafale@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: Context transition error
References: <492709F5.2090801@gmail.com> <1227297581.7319.54.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1227297581.7319.54.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 

> On Fri, 2008-11-21 at 20:20 +0100, Vince Le Port wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Dear all,
>>
>> I am working on a mean to change the nfs server context depending on the
>> user who wants to access his files. I have planned to use MCS to do that.
>>
>> Here is the approach for NFS:
>>
>> Let us say, we have two users : client1 in s0:c1 and client2 in s0:c2
>> If client1 wants to access his home directory mounted with NFS, then the
>> NFS daemon will change his MCS category corresponding to the client MCS
>> category
>> That will limit the risk that client2 could access client1's files
>>
>> Thus, for example my test program is launched in that context :
>> sysadm_u:sysadm_r:sysadm_t:s0:c1.c2
>>
>> Then that program makes a setcon in order to move into
>> sysadm_u:sysadm_r:sysadm_t:s0:c1 and the following step is to move the
>> program in that context sysadm_u:sysadm_r:sysadm_t:s0:c2
>>
>> I have written the following semodule :
>>
>> module localadmin 1.0;
>>
>> require {
>>         type sysadm_t;
>>         class process setcurrent;
>>         class process dyntransition;
>> }
>>
>> allow sysadm_t self:process { setcurrent dyntransition };
>>
>> The problem is that this setcon does not work. Audit launches a
>> dyntransition permission denied :
>>
>> type=AVC msg=audit(1224660818.891:422): avc: denied { dyntransition }
>> for pid=18334 comm="prog" scontext=sysadm_u:sysadm_r:sysadm_t:s0:c2
>> tcontext=sysadm_u:sysadm_r:sysadm_t:s0:c1 tclass=process
>>
>> It also seems impossible to return back to the original context s0:c1.c2
>> , once s0:c1 is reached
>>
>> Is it possible to allow this transition?
>>
>> Thanks you for helping a SElinux newbie
>
> The domain needs the mcssetcats attribute in order to pass the MCS
> policy constraints.
>
> You can use the mcs_process_set_categories() refpolicy interface if
> building using the refpolicy infrastructure (i.e. yum install
> selinux-policy-devel, make -f /usr/share/selinux/devel/Makefile
> localadmin.pp).
>
> I'm not sure what you are really planning to do though, as:
> - obviously your program should not run in sysadm_t,
> - The real processing for nfsd is handled by kernel threads, not a
> userland process, and thus can change its credentials without going
> through permission checks,
> - you still need a mechanism of binding the client process security
> context to the NFS request and conveying that to the server.
>
> You may wish to have a look at the ongoing labeled NFS work:
> http://selinuxproject.org/page/Labeled_NFS
>
Hi list,

Your answer helped me so much. I have succeeded in making my test
program running properly.

I am now working on the NFS server side modification.

I have made some searches around the use of setcon , and it seems that
this function is only available in the user space, not into the kernel.
Am I wrong saying that?

Does anybody know the equivalent of setcon in kernel mode?
Moreover I did not find the source code of the setcon function... where
could I find it ?

Regards,

Vince

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
 
iD8DBQFJNUk5CkDrToteDh0RAhMiAJ93nCGnsz9M/TK5XI91o+x9/v7TRgCgjARV
w4lfWN+fJbxHZM39foeOync=
=Ehls
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
