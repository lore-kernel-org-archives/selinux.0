Subject: Re: Copying/setting security.selinux xattr explicitly
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <56BB17FC.70507@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56BB4997.5080403@tycho.nsa.gov>
Date: Wed, 10 Feb 2016 09:30:47 -0500
MIME-Version: 1.0
In-Reply-To: <56BB17FC.70507@debian.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/10/2016 05:59 AM, Laurent Bigonville wrote:
> Hello,
>
> I've a question concerning copying the security.selinux xattr explicitly.
>
> In you opinion what should happen in an implementation if it cannot be
> reset security.selinux on the target file?
>
> Apparently GNU cp -a ignore failures (while cp --preserve=context fails).
>
> In some python helper function (_copyxattr(), see
> https://bugs.python.org/issue14082), it will return an exception if the
> copy of any of the xattr is failing, there is no special case for
> security.selinux.
>
> What do you think should be the behavior here?

The rationale for the difference in behavior between cp -a and cp 
--preserve=context is that cp -a usage predates SELinux (and extended 
attributes) and treating the inability to set the SELinux attribute on 
the destination file as a hard failure would have broken many existing 
uses of cp -a.

That is in fact generally true for all extended attributes, since trying 
to set any of them could fail due to lack of permission (except perhaps 
user.*) or due to lack of extended attribute support in the destination 
filesystem.

Looking at the patches in the bug/issue you cited, it looks like they 
actually ignore errno.EPERM, errno.ENOTSUP, and errno.ENODATA.  So the 
only one they don't ignore that SELinux might return would be errno.EACCES.

I'm a bit unclear on the intended semantics of shutil.copy2(), as on the 
one hand they say it is supposed to be like cp -p (which does not copy 
extended attributes at all) but on the other hand they now say that it 
copies all metadata that it can.
