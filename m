Subject: Re: XML Based Policy Configuration for SELinux
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Joshua Brindle <jbrindle@tresys.com>, alexander-barclay@utulsa.edu,
   Brandon Pollet <brandon@utulsa.edu>, SELinux@tycho.nsa.gov,
   John Hale <john-hale@utulsa.edu>
In-Reply-To: <20050622223842.GH14480@lkcl.net>
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu>
	 <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu>
	 <20050621212059.GA9434@lkcl.net> <42B8A699.206@tresys.com>
	 <20050622004114.GH9859@lkcl.net> <42B8DF16.3060108@tresys.com>
	 <20050622053327.GB14480@lkcl.net> <42B94A03.8020508@tresys.com>
	 <20050622223842.GH14480@lkcl.net>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 20:22:32 -0400
Message-Id: <1119486152.7677.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>  * a library, written in [probably] c and then wrapped with swig,
>    which understands and provides access to the contents of
>    /etc/selinux/*
> 
>    then, utilities and programs which "manipulate" selinux policy can
>    conveniently be written in c and with some awkwardness [due to swig]
>    written in any other programming language.

I'd like to note that I'm currently working on a small piece of 
that - placing the necessary code to work with file_contexts
and net_contexts, and local.users from the libsepol library.
Basically, I need to integrate useradd utilities with
the selinux code, so roles and per user contexts are
added/deleted/modified automatically.

It's not what you're describing, but at least it provides
some parsing code that generates a data structure (record)
that you can later pass to handlers and accomplish various
things more easily. I have written functions to iterate
a file of a single kind of record (such as the file_contexts 
file) and execute arbitrary handler that's individually
passed each record. I can also modify records with
a handler, delete records, and re-write
the file (preserving comments). Current status is debugging, 
and adding more validation/rollback features to the 
few handlers I've written.

It's not what you're describing, but it mostly does what
we need for useradd integration, and can be extended 
with more features later. The point is, it's not so
hard to get something up and running in C, as you
describe it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
