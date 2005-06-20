Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1119280879.30000.48.camel@rodan.ncc.com>
References: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
	 <1119137931.11593.53.camel@rodan.ncc.com>
	 <a1025d74050620061231e65d7d@mail.gmail.com>
	 <1119280879.30000.48.camel@rodan.ncc.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 11:40:47 -0400
Message-Id: <1119282047.2766.26.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> This is totally bizarre - why would the directory location affect it? 

The directory location does not affect it. The security type does.
SELinux does not pay attention to the user - it pays attention to
the security context. You can see the security context by typing
ls -Z <file>.

When you copy files into directories, you're changing their 
security context, much like changing permissions.

> Is this normal or a bug in my setup? 

This is probably normal.

> 
> Not to complain but if selinux breaks (fixes?) something as universal as
> the ability of a program to use stdout, there should be a big red
> warning label in the docs, saying "Look out! Programs that use stdout
> will not work unless you put them in certain directories!" But that's
> just me...

Everything not specifically allowed on SELinux is forbidden.
If you have no good reason for a certain privilege, then you're not
granted that privilege.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
