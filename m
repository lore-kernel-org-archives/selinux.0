Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5C8CXrT009693
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 04:12:33 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5C8CUEu005149
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 04:12:30 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 12 Jun 2004 08:12:31 -0000
Date: Sat, 12 Jun 2004 08:09:48 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Park Lee <parklee_sel@yahoo.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Regular Expression Problem
Message-ID: <20040612080948.GP2861@lkcl.net>
References: <20040612063426.65218.qmail@web51509.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040612063426.65218.qmail@web51509.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2004 at 11:34:26PM -0700, Park Lee wrote:
> Hi,
>  
> In the file_contexts file, I found some regular expressions. I studied them for a while, but still can't understand them well.
>  
> For example:  /var(/.*)
>  
> As I know: '.' stands for any character;
> Let's suppose '.' now stands for character 'a'. 
> then '/var(/.*)' can mean:
> '/var/a','/var/aa','/var/aaa','/var/aaaa','/var/aaaaa', ... ...
>  
> But now, If I have a file or directory named 'abc' in directory '/var' (i.e., 
> /var/abc). How can it match '/var(/.*)' ?
  
  well, i don't pretend to understand regular expressions either:
  they are one of the most obscure nasty amazingly compact hang-overs
  from the days when computers didn't have enough space to store
  wordey programs or programming languages.

  i think you'll find that the regular expression you are referring to
  is "/var(/.*)?" note the question mark which means it's optional.

  dot means any one character, and star means zero or more characters.

  so dot star means "one or more characters".

  
  obtuse as it is, can i recommend that you read up on several
  sources of regular expressions, for example "man regex"
  and also

	  http://www.google.com/search?q=regular+expressions



  remember we said google is your friend?  well we REALLY MEANT IT!

  if you don't know about something, put some random words into
  google, first.

  THEN if you can't find an answer, and it's definitely SE/Linux
  related, ask.

  sincerely,

  l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
