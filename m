Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5SFYpLk009292
	for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 11:34:51 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5SFYpmf013135
	for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 15:34:51 GMT
Received: by wr-out-0506.google.com with SMTP id i7so456086wra
        for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 08:34:50 -0700 (PDT)
Message-ID: <44A2A198.3050909@gmail.com>
Date: Wed, 28 Jun 2006 11:34:48 -0400
From: David-Alexandre Davidson <ryvore@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: Wrong tclass on a cifs share content
References: <44A2966A.2040905@gmail.com> <1151507942.20419.247.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1151507942.20419.247.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------030405090904020602030003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030405090904020602030003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Wed, 2006-06-28 at 10:47 -0400, David-Alexandre Davidson wrote:
>   
>> When accessing folders over a cifs share from a selinux context, I get 
>> audit messages, reporting denied actions
>> such as 0x100000 and 0x200000 , which refers to search, and rmdir. The 
>> problem is that selinux incorrectly
>> report the target class as "file", when it is in reality a "dir" 
>> element. Being unable to map these Hex code to
>> a valid action for a file, every request is denied no mater what policy 
>> rules are in effect. (actions like read,
>> setattr, getattr are valid because they are the same for file and dir 
>> elements)
>>
>> I'm running Fedora core 5 with the lastest stable kernel, and it can 
>> easily be reproduced. Just map a cifs share,
>> (I use automount) and attempt a rmdir  /theshare/sample_dir  as root. 
>> and then :
>>
>> type=AVC msg=audit(1151197545.712:144): avc:  denied  { 0x200000 } for  pid=2608
>> comm="rmdir" name="sample_dir" dev=cifs ino=8889
>> scontext=root:staff_r:staff_t:s0-s0:c0.c255 tcontext=system_u:object_r:cifs_t:s0
>> tclass=file
>>
>>
>> If anyone can help on that matter, or tell me who I should report this 
>> to, it would be very appreciated. I
>> believe it is related to the kernel either at the point the labeling is 
>> made when the share is mounted, or
>> if not, when selinux lookup the tclass on those element. Without 
>> selinux, everything work fine, and no file
>> system error occur. I'll be browsing the source code to find more 
>> details about what causes this issue,
>> but I'm not really familiar with that part of the kernel source.
>>     
>
> It is a bad interaction between cifs and selinux.  Did you file a
> bugzilla against the kernel as I suggested when you initially raised
> this report on fedora-selinux-list?  SELinux does its inode security
> setup upon d_instantiate, and expects the fs to have set up the base
> inode state (such as the inode mode) by that point.  cifs appears to
> violate this expectation.  One or the other will have to change.
>
> If you just want to allow staff_t to perform arbitrary actions on the
> mount, you could add:
> 	allow staff_t cifs_t:file *;
>
>   
Thanks for the details, at the moment, that allow rule does the work, or 
I can simply work with
selinux, in permissive mode but I require more control on my final 
system setup.

Here is the link to the bug report :
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=196567 
<https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=196567>


-----------------------------
David-Alexandre Davidson

--------------030405090904020602030003
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Stephen Smalley wrote:
<blockquote
 cite="mid1151507942.20419.247.camel@moss-spartans.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">On Wed, 2006-06-28 at 10:47 -0400, David-Alexandre Davidson wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">When accessing folders over a cifs share from a selinux context, I get 
audit messages, reporting denied actions
such as 0x100000 and 0x200000 , which refers to search, and rmdir. The 
problem is that selinux incorrectly
report the target class as "file", when it is in reality a "dir" 
element. Being unable to map these Hex code to
a valid action for a file, every request is denied no mater what policy 
rules are in effect. (actions like read,
setattr, getattr are valid because they are the same for file and dir 
elements)

I'm running Fedora core 5 with the lastest stable kernel, and it can 
easily be reproduced. Just map a cifs share,
(I use automount) and attempt a rmdir  /theshare/sample_dir  as root. 
and then :

type=AVC msg=audit(1151197545.712:144): avc:  denied  { 0x200000 } for  pid=2608
comm="rmdir" name="sample_dir" dev=cifs ino=8889
scontext=root:staff_r:staff_t:s0-s0:c0.c255 tcontext=system_u:object_r:cifs_t:s0
tclass=file


If anyone can help on that matter, or tell me who I should report this 
to, it would be very appreciated. I
believe it is related to the kernel either at the point the labeling is 
made when the share is mounted, or
if not, when selinux lookup the tclass on those element. Without 
selinux, everything work fine, and no file
system error occur. I'll be browsing the source code to find more 
details about what causes this issue,
but I'm not really familiar with that part of the kernel source.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It is a bad interaction between cifs and selinux.  Did you file a
bugzilla against the kernel as I suggested when you initially raised
this report on fedora-selinux-list?  SELinux does its inode security
setup upon d_instantiate, and expects the fs to have set up the base
inode state (such as the inode mode) by that point.  cifs appears to
violate this expectation.  One or the other will have to change.

If you just want to allow staff_t to perform arbitrary actions on the
mount, you could add:
	allow staff_t cifs_t:file *;

  </pre>
</blockquote>
Thanks for the details, at the moment, that allow rule does the work,
or I can simply work with<br>
selinux, in permissive mode but I require more control on my final
system setup.<br>
<br>
Here is the link to the bug report :<br>
<a onclick="return top.js.OpenExtLink(window,event,this)"
 href="https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=196567"
 target="_blank">https://bugzilla.redhat.com<wbr>/bugzilla/show_bug.cgi?id<wbr>=196567</a><br>
<br>
<br>
-----------------------------
<br>
David-Alexandre Davidson
</body>
</html>

--------------030405090904020602030003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
