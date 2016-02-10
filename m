Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1AErcFK001155
 for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2016 09:53:38 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 10C001A1D5
 for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2016 15:53:34 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ck-LpBQqDFMP for <selinux@tycho.nsa.gov>;
 Wed, 10 Feb 2016 15:53:30 +0100 (CET)
Received: from [10.20.187.159] (unknown [193.53.238.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 7D9181A1B0
 for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2016 15:53:30 +0100 (CET)
Subject: Re: Copying/setting security.selinux xattr explicitly
To: selinux@tycho.nsa.gov
References: <56BB17FC.70507@debian.org> <56BB4997.5080403@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <56BB4EE9.1080309@debian.org>
Date: Wed, 10 Feb 2016 15:53:29 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <56BB4997.5080403@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 10/02/16 15:30, Stephen Smalley a écrit :
> On 02/10/2016 05:59 AM, Laurent Bigonville wrote:
>> Hello,
>>
>> I've a question concerning copying the security.selinux xattr 
>> explicitly.
>>
>> In you opinion what should happen in an implementation if it cannot be
>> reset security.selinux on the target file?
>>
>> Apparently GNU cp -a ignore failures (while cp --preserve=context 
>> fails).
>>
>> In some python helper function (_copyxattr(), see
>> https://bugs.python.org/issue14082), it will return an exception if the
>> copy of any of the xattr is failing, there is no special case for
>> security.selinux.
>>
>> What do you think should be the behavior here?
>
> The rationale for the difference in behavior between cp -a and cp 
> --preserve=context is that cp -a usage predates SELinux (and extended 
> attributes) and treating the inability to set the SELinux attribute on 
> the destination file as a hard failure would have broken many existing 
> uses of cp -a.
>
> That is in fact generally true for all extended attributes, since 
> trying to set any of them could fail due to lack of permission (except 
> perhaps user.*) or due to lack of extended attribute support in the 
> destination filesystem.
>
> Looking at the patches in the bug/issue you cited, it looks like they 
> actually ignore errno.EPERM, errno.ENOTSUP, and errno.ENODATA.  So the 
> only one they don't ignore that SELinux might return would be 
> errno.EACCES.
>
> I'm a bit unclear on the intended semantics of shutil.copy2(), as on 
> the one hand they say it is supposed to be like cp -p (which does not 
> copy extended attributes at all) but on the other hand they now say 
> that it copies all metadata that it can.
>
Not too sure either.

I've proposed them to either ignore error when the xattr is 
security.selinux or ignore EACCES errors altogether.

See: https://bugs.python.org/issue26328
