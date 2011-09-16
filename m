Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GERU1v020371
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 10:27:30 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GERSGq016818
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 14:27:29 GMT
Message-ID: <4E735CCB.5070603@redhat.com>
Date: Fri, 16 Sep 2011 10:27:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 35/67] policycoreutils: sandbox: FIXME add level based
 kill
References: <4E7255EB.3000804@redhat.com> <1316148577.2364.28.camel@vortex> <1316151193.2364.38.camel@vortex>
In-Reply-To: <1316151193.2364.38.camel@vortex>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/16/2011 01:33 AM, Guido Trentalancia wrote:
> On Fri, 2011-09-16 at 06:49 +0200, Guido Trentalancia wrote:
>> On Thu, 2011-09-15 at 15:45 -0400, Daniel J Walsh wrote:
>>> @@ -941,6 +1011,9 @@ childerr: waitpid(child, &status, 0); 
>>> status_to_retval(status, status);
>>> 
>>> +       if (execcon && kill_all) +
>>> killall(execcon); + if (tmpdir_r) cleanup_tmpdir(tmpdir_r,
>>> tmpdir_s, pwd, 1);
>>> 
>>> err:
>> 
>> Was it not just "kill" instead of "kill_all" ?
> 
> I just realised that variable is going to get renamed in another
> patch ([PATCH 36/67] policycoreutils: sandbox: cntrl-c should kill
> entire). So I think this patch requires 36/67, that's it but was
> not evident at first sight.
> 
> Guido
> 
kill  would conflict with the function kill.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5zXMsACgkQrlYvE4MpobP5twCdFv8PeXU5xxUK8jVlDh4AEGpC
jjQAnRsPrMSo0umWF4NeSO/+0iKg64TB
=DEO6
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
