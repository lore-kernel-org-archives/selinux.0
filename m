Subject: Re: setools4 support
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9ad54b8d-b273-3d04-c571-b05faa39081c@tycho.nsa.gov>
Date: Fri, 23 Sep 2016 16:39:36 -0400
MIME-Version: 1.0
In-Reply-To: <1474557453-14379-1-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/22/2016 11:17 AM, Jason Zaman wrote:
> Hi all,
> 
> I finally got everything updated to use setools4. The most complicated parts
> were sepolicy.search() and sepolicy.info() which were largely undocumented. I
> dumped and diff'd the output from the old and new code so am fairly confident
> that they are the same (barring some issues that setools3 appears to have with
> cil). I also changed several places to just use setools directly, having the
> indirection through search() mostly just complicates and slows things down.
> 
> The first patch is just cleanup. Next imports and initializes setools.
> Patches 3-4 update a lot of the users of search() and info() to work with the next
> changes.
> Patches 5-6 update search() and info() themselves and the last drops the C
> module completely
> 
> I dont know the status of setools4 on fedora (someone else will have to update
> the README if needed) or others but I've added it masked in gentoo a fair while
> ago. Once this patchset is merged we can finally get rid of setools3, its been
> half-broken for a while now.

Thanks, applied the entire series.
