Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1119137931.11593.53.camel@rodan.ncc.com>
References: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
	 <1119137931.11593.53.camel@rodan.ncc.com>
Content-Type: text/plain
Date: Sun, 19 Jun 2005 02:45:58 -0400
Message-Id: <1119163558.3884.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 2. How do I get a new scripts or program to run? One FAQ came near to
> answering this but was incomplete. It said I should run the offending
> program, then extract the warning line from the messages file and run it
> through a program called audit2allow. Audit2allow seems to need an input
> file so I copied one of the warning lines from the log into a text file,
> test.txt, and did this:
> 
> audit2allow test.txt

I wish FAQs would stop recommending this, since that's what everyone 
does to get their scripts to run. audit2allow is a helper program
for policy writers, and nothing more. It's a mistake to pipe
its output into anything... instead you should provide that to the
SELinux people, so they can write proper policy.

> The result message from audit2allow was "allow httpd_sys_script_t
> devpt_t:chr_file { read write };". The "allow" sounded hopeful but when
> I tried to run my script again it still didn't work. So I think there
> must be some additional step that was left out of the FAQ. Any
> suggestions appreciated.

This particular error means that your script cannot write to 
the terminal. I also suspect the terminal is labeled incorrectly,
but someone else would have to comment on that - I am still
not understanding the different devpts* types very well.

Why do you need your scripts to write to the terminal?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
