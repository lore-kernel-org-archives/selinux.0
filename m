Subject: Re: sepolicy and setools4
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <20160819153528.GA21357@meriadoc.perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d6225fdc-fa59-0057-2710-9ee72be99c51@tycho.nsa.gov>
Date: Fri, 19 Aug 2016 15:04:17 -0400
MIME-Version: 1.0
In-Reply-To: <20160819153528.GA21357@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/19/2016 11:35 AM, Jason Zaman wrote:
> Hi all,
> 
> I've been trying to finally get rid of the last users of setools3 since
> its basically on life support. I have a lot of things fixed locally but
> not quite in good enough shape to submit.
> 
> Sepolicy currently is the thing that uses setools3 and everything else
> mostly goes via sepolicy. It boils down to sepolicy.info() and
> sepolicy.search() which are C-wrappers to setools3. Those two methods
> have a very open-ended and confusing API, and are just very thin
> wrappers around setools. It seems to me that we'd be better off updating
> most things that use it to instead use setools4 directly.
> 
> I have fixed .info() already (although still untested) so .search() is
> the main problem. It takes dictionaries of stuff and returns
> dictionaries of stuff and what exactly is in the dictionaries is not
> that clear.
> 
> How many users outside of the tree are there for sepolicy directly? If
> the only users are in the tree, I'd much rather kill off
> sepolicy.search() and go directly to setools. Is that an option?

I'm all for doing that.

> slawrence mentioned on IRC that setroubleshoot might use sepolicy but
> wasnt entirely sure. Even if it does, does it use .search() and .info()?
> or does it only use all the other methods from it?

cc'd the folks who might know about setroubleshoot.
