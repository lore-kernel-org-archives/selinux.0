Message-ID: <53064577.9040308@tycho.nsa.gov>
Date: Thu, 20 Feb 2014 13:12:07 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>, SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Re: [RFC] [PATCH] load_policy: Log errors using selinux_log
References: <20140220135440.C93E9680220@frontend2.nyi.mail.srv.osa>
In-Reply-To: <20140220135440.C93E9680220@frontend2.nyi.mail.srv.osa>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/20/2014 08:49 AM, Colin Walters wrote:
> This libselinux patch won't actually apply to git master of selinux, as
> it's really on top of the Fedora libselinux package which is carrying a
> patch to use LZMA compression.
> 
> This is more of a RFC - I wrote these patches to debug a problem which
> I've now (mostly) solved, but they may help someone else in the future...

Agreed, we did the same in the corresponding function for Android policy
loading.

> One question - systemd git has this comment:
> 
> /* Make sure we have no fds open while loading the policy and
> * transitioning */
> log_close();
> 
> Introduced by this commit:
> http://cgit.freedesktop.org/systemd/systemd/commit/?id=0b3325e7
> 
> Is that really necessary?  Something relating to the labels of the fds?
> If so, is there something we can do to allow logging?  I could probably
> change the systemd log handler to write to a memory buffer or something
> if it's necessary.
> 
> For reference I'm attaching my (currently somewhat unclean) systemd
> patch as well.

Probably just to avoid needing to allow the new context to use fds with
the old context in policy, but likely not critical.
