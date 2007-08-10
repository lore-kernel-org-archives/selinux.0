Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AMDHvk013815
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 18:13:21 -0400
Received: from web36611.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7AMDAuE005690
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 22:13:16 GMT
Date: Fri, 10 Aug 2007 15:13:10 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
To: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
        steved@redhat.com, trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <635572.72239.qm@web36611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> These patches add local caching for network filesystems such as NFS and AFS.
> 
> FS-Cache now runs fully asynchronously as required by Trond Myklebust for
> NFS.
> 
> --
> Changes:
> [try #3]:
> 
>  (*) Added missing file to CacheFiles patch.
> 
>  (*) Made new security functions return errors and pass actual return data
> via
>      argument pointer.
> 
>  (*) Cleaned up NFS patch.
> 
>  (*) The 'fsc' flag must now be passed to NFS mount by the string options.
> 
>  (*) Split the NFS patch into three as requested by Trond.
> 
> [try #2]:
> 
>  (*) The CacheFiles module no longer accepts directory fds in its cull and
>      inuse commands from cachefilesd.  Instead it uses the current working
>      directory of the calling process as the basis for looking up the object.
>      Corollary to this, fget_light() no longer needs to be exported.
> 

How would you expect an LSM that is not SELinux to interface with
CacheFiles? You have gone to a great deal of effort to support the
requirements of an SELinux system, and that's good, but you have
extended the LSM interface to expose SELinux data structures (secids)
and require them for the operation of CacheFiles, and that's bad.
The data used within an LSM is private to the LSM, and this applies
to SELinux as well as to any other LSM that may come along, such
as the Smack LSM I'm working on. This applies to task data as well
as file data. Further, the behavior of the system in the presence
of an LSM should be controlled by the LSM, it is more than a little
scary that CacheFiles is enforcing SELinux policy based on secids
that may be coming from a different LSM.

I applaud the integration of CacheFiles with SELinux. Unfortunately,
you've done so using the LSM interface in such a way that an LSM
other than SELinux is likely to demonstrate inappropriate behaviors
in the presence of CacheFiles because you have so carefully integrated
the SELinux requirements.

If the integration with SELinux is important to you, and I would
expect that it is given the work you've put into it, I suggest that
the SELinux specific behaviors be identified so that another LSM
can provide the behavior appropriate to the policy it chooses to
enforce and put that into SELinux with an LSM interface. I know
that you're looking at a significant effort to do that, but I
wouldn't think that you'd want CacheFiles to behave badly in the
presence of an LSM that doesn't happen to be SELinux.

I also know it's tempting to point out the SELinux is the only
upstream LSM. I hope to change that before too long, and I know
there are others with ambitions as well. I would not like to see
CacheFiles have to get excluded in the presence of other LSMs
and I doubt you would either.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
