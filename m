Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82EjeLa016598
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 10:45:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h82Ei2pS029530
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 14:44:08 GMT
Message-ID: <3F54ACFE.8090807@redhat.com>
Date: Tue, 02 Sep 2003 10:45:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, James Morris <jmorris@redhat.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ls --context of /selinux
References: <200309021723.27716.russell@coker.com.au> <1062506326.18568.27.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1062506326.18568.27.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------090104010300020608050101"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------090104010300020608050101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have recieved a bug report on this, so I am fixing and should have a 
new rpm today.

Dan

Stephen Smalley wrote:

>On Tue, 2003-09-02 at 03:23, Russell Coker wrote:
>  
>
>>What are the plans regarding "ls --context /selinux"?
>>
>>Currently the lgetxattr() system call returns -1 (EOPNOTSUPP) and the current 
>>ls patch (taken from Dan's repository) refuses to even allow "ls -l" because 
>>of it (probably a bug in ls as I imagine that there will always be file 
>>systems that don't support it).
>>
>>Will "ls --context /selinux" ever work?
>>    
>>
>
>Since SELinux migrated to using xattr, the utilities can only get and
>set the contexts of files in a filesystem if it provides an xattr
>handler.  There doesn't seem to be any reason to support getting or
>setting contexts on selinuxfs entries, so I wouldn't expect us to
>implement an xattr handler for it.  The 'ls' in the patched coreutils
>from the NSA SELinux site simply displays (null) in the context field
>for such filesystems; I'm not sure why Dan has changed the behavior in
>his latest patch.  There will always be at least some filesystem types
>that will not provide xattr handlers, so it does need to cleanly handle
>this case.
>
>  
>

--------------090104010300020608050101
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
I have recieved a bug report on this, so I am fixing and should have a
new rpm today.<br>
<br>
Dan<br>
<br>
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1062506326.18568.27.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Tue, 2003-09-02 at 03:23, Russell Coker wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">What are the plans regarding "ls --context /selinux"?

Currently the lgetxattr() system call returns -1 (EOPNOTSUPP) and the current 
ls patch (taken from Dan's repository) refuses to even allow "ls -l" because 
of it (probably a bug in ls as I imagine that there will always be file 
systems that don't support it).

Will "ls --context /selinux" ever work?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Since SELinux migrated to using xattr, the utilities can only get and
set the contexts of files in a filesystem if it provides an xattr
handler.  There doesn't seem to be any reason to support getting or
setting contexts on selinuxfs entries, so I wouldn't expect us to
implement an xattr handler for it.  The 'ls' in the patched coreutils
from the NSA SELinux site simply displays (null) in the context field
for such filesystems; I'm not sure why Dan has changed the behavior in
his latest patch.  There will always be at least some filesystem types
that will not provide xattr handlers, so it does need to cleanly handle
this case.

  </pre>
</blockquote>
</body>
</html>

--------------090104010300020608050101--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
