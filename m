From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@servalens.com, SELinux@tycho.nsa.gov
Subject: Re: Future of selinux/lsm
Date: Tue, 2 Dec 2003 13:49:26 +1100
References: <2700.165.247.144.4.1070315301.squirrel@webmail.servalens.com>
In-Reply-To: <2700.165.247.144.4.1070315301.squirrel@webmail.servalens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312021349.26640.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Dec 2003 08:48, selinux@servalens.com wrote:
> I read that LSM was being pulled from the 2.6 kernel. Is this true?

Where did you read that?

I find it very unlikely that LSM would be pulled from the kernel after all the 
time and effort that has gone into it.  LSM was created at the request of 
Linus, and getting it into it's current shape has taken a significant amount 
of work by a large number of people.  There would need to be a very good 
reason for code to be dumped from the Linux kernel tree after so much work.

I would be more likely to believe something I read in the "Weekly World News" 
than such a rumor (WWN broke the story about Elvis not being dead).

> If so, does that mean SELinux will move back to the kernel patch model?
> I am looking for some strategic guidance for a deployment planning.
> The choice would be maintaining a patched 2.4x kernel or going bleeding
> edge with a 2.6 kernel.

Red Hat has made a commitment to SE Linux.  Regardless of all else you can 
expect that Red Hat 2.6 kernel packages will continue to have SE Linux.


Maybe I should contribute an article for WWN, "Elvis patches kernel to remove 
LSM and uploads it from a UFO".  It would probably go well in the WWN 
technology section.  :-#

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
