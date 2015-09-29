Subject: Re: newrole not working when built with LSPP_PRIV=y
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov,
 Daniel J Walsh <dwalsh@redhat.com>
References: <560741F0.9090709@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AE811.7070008@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 15:35:45 -0400
MIME-Version: 1.0
In-Reply-To: <560741F0.9090709@debian.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/26/2015 09:10 PM, Laurent Bigonville wrote:
> Hi,
>
> Running newrole executable compiled with LSPP_PRIV=y I get the following
> error while it's trying to switch role:
>
> Error sending audit message.
>
> It seems that the CAP_AUDIT_WRITE capability is not set [0]. Adding this
> capability to the list doesn't seems enough, I then get the following error:
>
> failed to exec shell: Operation not permitted
>
> Looking at the fedora tree, I've found this patch[1] (which is not
> merged upstream) that seems to fix both issues.
>
> The patch seems to break an other thing, it Fedora the newrole
> executable is not setuid root, but it is granted a bunch of capabilities
> explicitly, if I setuid this executable instead of granting these
> capabilities, I get yet an other error:
>
> Sorry, newrole failed to drop capabilities: Operation not permitted
>
> So I guess something need to be fixed here.

Yes, the current code just seems to be wrong here.  The setresuid() call 
will drop all capabilities if newrole is setuid-root and the caller is 
non-root, so it will end up dropping all capabilities immediately.  Then 
the attempt to further set the capabilities will fail (as above), as 
will any subsequent privileged operations.  As currently written, this 
can only work if not setuid-root and using file-caps.  And in that case, 
the setresuid() call doesn't make sense.

Dan?

>
> Cheers,
>
> Laurent Bigonville
>
> [0]
> https://github.com/SELinuxProject/selinux/blob/master/policycoreutils/newrole/newrole.c#L590
>
> [1]
> https://github.com/fedora-selinux/selinux/commit/339a6fed0b37f8b82e4382bc6a5c9367119ed92b
