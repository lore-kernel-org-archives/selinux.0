Message-ID: <527275AC.2020206@tycho.nsa.gov>
Date: Thu, 31 Oct 2013 11:22:20 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-NSA <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Joshua Brindle <brindle@quarksecurity.com>,
        Steve Lawrence <slawrence@tresys.com>
Subject: Re: Pruning dead/obsolete branches?
References: <5271566F.4070207@tycho.nsa.gov>
In-Reply-To: <5271566F.4070207@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/30/2013 02:56 PM, Stephen Smalley wrote:
> Hi,
> 
> There are a number of old branches in the selinux repo that I think can
> be safely pruned, but I wanted to confirm first.
> 
> The branches other than master are:
<snip>
> - queue:  Eric's branch for changes queued for merging to master, kind
> of a next branch.  Last commit Feb 2013.

So on the queue branch, I see many commits that have been merged albeit
in different form but others that have not, e.g.

commit 56834fe9295e9539da49ca7f02270389c29f31e0
Author: Dan Walsh <dwalsh@redhat.com>
Date:   Tue Feb 5 17:08:27 2013 -0500

    policycoreutils: seunshare: creating NEWIPC for each sandbox

    To make sure we don't have a conflict on semaphores or other IPC
    mechanisms between 2 sandboxes.

    Signed-off-by: Eric Paris <eparis@redhat.com>

commit fcf02585e898360a631dbf7d3d383556d6f5c9a0
Author: Eric Paris <eparis@redhat.com>
Date:   Tue Feb 5 15:15:14 2013 -0500

    policycoreutils: newrole: error on fcntl failure

    We were trying to clear O_NONBLOCK from fd 0,1,2 but did not check the
    return code.  We should check the return value and error out if it
    failed.

    Signed-off-by: Eric Paris <eparis@redhat.com>

commit 1e5eff0e1685fc05549a4ae749f56efad6f8599a
Author: Eric Paris <eparis@redhat.com>
Date:   Tue Feb 5 15:10:05 2013 -0500

    policycoreutils: newrole: check return of fcntl in relabel_tty

    In relabel_tty we open the tty O_NONBLOCK then immediately clear
    O_NONBLOCK.  This is so the open() will quickly return EWOULDBLOCK and
    we do not deadlock.  We were not checking the return value of the fcntl.
    Check that return value.

    Signed-off-by: Eric Paris <eparis@redhat.com>

Were these intentionally dropped or just lost?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
