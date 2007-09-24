Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8OIYsir015705
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 14:34:54 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8OIYq7p022224
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 18:34:52 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l8OITeF6010800
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 14:29:40 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l8OITevx010799
	for selinux@tycho.nsa.gov; Mon, 24 Sep 2007 14:29:40 -0400
Message-ID: <46F7BC3D.2040408@redhat.com>
Date: Mon, 24 Sep 2007 09:31:41 -0400
From: Peter Staubach <staubach@redhat.com>
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Steve Dickson <SteveD@redhat.com>
Subject: Re: [PATCH 14/22] NFS: Use local caching
References: <10249.1190416956@redhat.com> <46F3F8BF.1030404@redhat.com> <20070921144703.8323.50492.stgit@warthog.procyon.org.uk> <20070921144815.8323.77745.stgit@warthog.procyon.org.uk> <10304.1190417846@redhat.com>
In-Reply-To: <10304.1190417846@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
>
>   
>> Peter Staubach <staubach@redhat.com> wrote:
>>
>>     
>>> Did I miss the section where the modified semantics about which
>>> mounted file systems can use the cache and which ones can not
>>> was implemented?
>>>       
>> Yes.
>>     
>
> fs/nfs/super.c:
>
> 		case Opt_sharecache:
> 			mnt->flags &= ~NFS_MOUNT_UNSHARED;
> 			break;
> 		case Opt_nosharecache:
> 			mnt->flags |= NFS_MOUNT_UNSHARED;
> 			mnt->options &= ~NFS_OPTION_FSCACHE;
> 			break;
> 		case Opt_fscache:
> 			/* sharing is mandatory with fscache */
> 			mnt->options |= NFS_OPTION_FSCACHE;
> 			mnt->flags &= ~NFS_MOUNT_UNSHARED;
> 			break;
> 		case Opt_nofscache:
> 			mnt->options &= ~NFS_OPTION_FSCACHE;
> 			break;
>
> Hmmm...  Actually, I'm not sure this is sufficient.

This doesn't seem to take into account any of the other options
which can cause sharing to be disabled.  Perhaps SteveD can add
his patch to the mix which does resolve the issues?

    Thanx...

       ps

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
