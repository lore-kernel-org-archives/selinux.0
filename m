Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA16219
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:25:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA16886
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 19:23:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA16882
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 19:23:09 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: Fwd: [ols-announce] OLS2003: Call for Papers
Date: Fri, 1 Nov 2002 20:24:50 +0100
To: selinux@tycho.nsa.gov
Cc: linux-security-module@wirex.com
MIME-Version: 1.0
Message-Id: <200211012024.50655.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So who's planning on offering a paper?

I'd like to offer a paper but at the moment I'm a bit stuck for ideas.  I've 
got two months to think up something new and exciting about SE Linux that I 
can write a paper on.  Any suggestions would be appreciated.

Adding some better security to X would be exciting.  But I'm not sure how much 
work it'll take to get something done.  I wouldn't do everything that's 
needed (IE Trusted Path), all I want to do is to stop user_games_t from 
sniffing the keyboard.  I'm thinking that the X server should have some 
knowledge of SE security contexts and know what rights a program has when it 
connects.  Hopefully this would then encourage other people to do further 
work on the areas that aren't important enough to me that I want to do them.

BTW  Have any of the people who said "I'd like to work on X security" actually 
done anything?

----------  Forwarded Message  ----------

Subject: [ols-announce] OLS2003: Call for Papers
Date: 01 Nov 2002 13:56:52 -0500
From: "Andrew J. Hutton" <ajh@linuxsymposium.org>
To: ols-announce@lists.linuxsymposium.org

We are happy to announce the Call for Papers for the 2003 Ottawa
Linux Symposium.  2003 is our 5th year and we're working on making
it the best Symposium yet.

You can view the Call for Papers at:
          http://www.linuxsymposium.org/2003/cfp.php

I would also like to thank all of the Review Committee members who
will be reviewing the proposals this year.

The 2003 Committee
          Alan Cox, Red Hat Software
          Andi Kleen, SuSE
          Mathew Wilcox, HP
          Gerrit Huizenga, IBM
          Andrew J. Hutton, Steamballoon
          C. Craig Ross, Linux Symposium
          Martin K. Petersen

If you're working on something cool or know someone who is
please consider submitting a proposal.  The secret to a great
event is great content!

Thank you to everyone who has made it in the past, and those of
you planning to be back next July.

Additional details:
	  http:/www.linuxsymposium.org/

Please feel free to direct any questions to ajh@linuxsymposium.org
and if you work for or know an organization who would be a good fit
as a Symposium sponsor drop me a note.

Thank you
the Symposium organizers.





_______________________________________________
ols-announce mailing list
ols-announce@lists.achilles.net
http://lists.achilles.net/mailman/listinfo/ols-announce

-------------------------------------------------------

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
