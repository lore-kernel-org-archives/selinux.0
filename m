Message-ID: <53BD5F61.1040405@tycho.nsa.gov>
Date: Wed, 09 Jul 2014 11:27:29 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov
Subject: Re: pcre compiled context files invalid with pcre updates?
References: <20140709151216.GA8142@siphos.be>
In-Reply-To: <20140709151216.GA8142@siphos.be>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/09/2014 11:12 AM, Sven Vermeulen wrote:
> Hi all,
> 
> In Gentoo, we notice some unexpected behavior with the compiled
> file_contexts files after upgrading (lib)pcre:
> 
> https://bugs.gentoo.org/show_bug.cgi?id=516608
> 
> I think what is happening is that the pcre data, which is built with one
> pcre version, is not (fully) compatible with a more recent pcre version. In
> the changelog of pcre I find type changes of (internal or not) variables by
> pcre.
> 
> If this assumption is correct, perhaps we should store the pcre version used
> to build the *.bin files in the file itself. Right now we store a magic (to
> make sure it is a compiled file_contexts file) and a version specific for
> libselinux, but not a version specific for PCRE.
> 
> The pcre header defines PCRE_MAJOR and PCRE_MINOR which we can use.
> 
> Do you think the above analysis makes sense? The bug linked earlier on has a
> gdb backtrace for those interested. Any other pointers that might help us
> troubleshoot this would be appreciated.

When this came up in:
http://marc.info/?t=137192124100002&r=1&w=2
the solution was to add a trigger to the selinux-policy package to
always rebuild the policy (which includes regenerating the .bin file) on
pcre upgrades.

Are you not doing that in Gentoo?

The issue came up again in the context of cross-compiling in:
http://marc.info/?t=139275881100002&r=1&w=2
and there was a willingness to add a version but I don't think anyone
proposed a patch to do so.  But even with the version, using the PCRE
version effectively just means that you'll need to regenerate on each
new library version anyway, right?  So what do we gain versus the
current approach of regenerating on pcre updates?
