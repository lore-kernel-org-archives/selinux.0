Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JAN93C032235
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 06:23:10 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JAN6fP017442
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 10:23:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
Subject: Re: Is SELinux appropriate for my use?
Date: Fri, 19 May 2006 19:58:53 +1000
Cc: selinux@tycho.nsa.gov
References: <446A0CE9.6020708@gmail.com> <200605171558.43653.russell@coker.com.au> <446CD37D.1020500@gmail.com>
In-Reply-To: <446CD37D.1020500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605191958.57451.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 19 May 2006 06:05, Tetsuji Maverick Rai 
<tetsuji.maverick.rai@gmail.com> wrote:
> Thank you for your reply.  But I still wonder....
>
> What if apache's permission is set so that it isn't allowed to execute
> most commands?    But actually most commands (i.e. even cat, ls) can be
> dangerous, because it will display files containing mysql password.   So
> does SELinux exist to prevent attackers from executing these "usual"
> programs with http server's permissions(role)?   If so, I can understand
> a bit....actually I understand this is secure.

Firstly, let's not consider cat etc (because with some difficulty we can 
prevent access to them).  Let's consider direct reads of files by the 
application.

Say for example that you have a text file with a MySQL password that is read 
by PHP code to connect to the database and you don't want some PHP code that 
has been exploited to read it and provide it to an attacker.  There is 
nothing we can do about this as all PHP code is run in the same process 
context.

One thing I would like to see is a PHP equivalent to Tomcat.  There is a 
cgi-bin version of PHP but that delivers less performance and also didn't 
provide equal functionality last time I tested (I tried to run Imp on it and 
failed for an unknown reason).  If PHP code ran in a separate process then 
Apache could connect to that process via HTTP and then the PHP server could 
run in a different SE Linux domain and different UID to the main Apache 
process.  But this still wouldn't solve your problem as all PHP scripts would 
run in the same context and one cracked PHP script could access all data 
that's available to any PHP script.

Of course ideally you could have multiple PHP servers on one machine and have 
them run with different privs.

> And what's more?
>
> I am writing this because SElinux isn't available with my favorite
> reiserfs.   I need to use xfs or jfs to use SELinux (I don't like
> ext2/3).  If reiserfs is compatible with SELinux, I'm sure I use
> SELinux....or I am wondering I should move to jfs...(xfs is too slow.)

Last time I tried ReiserFS an install of Fedora with SE Linux on a ReiserFS 
root would fail badly (the install would be corrupted and it wouldn't work 
without SE Linux either).  But when I installed on ReiserFS without SE Linux 
and then converted the machine to SE Linux then it worked OK.

It seems that recent kernel changes broke ReiserFS again, I just did a test on 
the latest rawhide kernel with a policy modified to support labelling on 
ReiserFS (the policy in rawhide labels all ReiserFS objects as nfs_t as 
ReiserFS is known to be broken) and created files got the label file_t.

I believe that JFS is in maintenance mode which makes it less desirable for 
future use.  While it apparently performs reasonably under extremely high 
load it's performance in most situations lags behind the other filesystems.  
XFS works for me, I have some Cobalt machines that won't boot from an ext2/3 
filesystem that is used by SE Linux and XFS works well on them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
