Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p67DuZl8027505
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 09:56:35 -0400
Received: from mail-gx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p67DuYt0016743
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 13:56:34 GMT
Received: by gxk9 with SMTP id 9so444834gxk.12
        for <selinux@tycho.nsa.gov>; Thu, 07 Jul 2011 06:56:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201107072319.14792.russell@coker.com.au>
References: <201107072319.14792.russell@coker.com.au>
Date: Thu, 7 Jul 2011 15:56:34 +0200
Message-ID: <CACLa4pvtqfe0nL9MObusdNEF-H+3s4mtrPgONKr1BT4JH6ieiw@mail.gmail.com>
Subject: Re: context NFS mounts
From: Eric Paris <eparis@parisplace.org>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm not sure what all the NFSv4 shared superblock magic is, but I
think you might need to mount with nosharecache.  See if that works
for you....

-Eric

On Thu, Jul 7, 2011 at 3:19 PM, Russell Coker <russell@coker.com.au> wrote:
> # mount TEST:/bin /mnt/tmp2 -o context=rjc:object_r:user_tmp_t:s0
> # mount TEST:/sbin /mnt/tmp -o context=rjc:object_r:user_tmp_t:s0:c1
> mount.nfs: an incorrect mount option was specified
>
> It seems that if a server named TEST exports two NFS mount points from the
> same filesystem (in this case /bin and /sbin both being on the root fs) then I
> can't have one NFS client mount them both with different SE Linux contexts.
>
> As I have subtree_check enabled on the server and the server doesn't export /
> it seems to me that there is no good reason for not allowing this.  If
> everything works as desired the result SHOULD be the same as if I had separate
> filesystems for /bin and /sbin.
>
> Should we consider this a bug or at least a missing feature?
>
> --
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
