Date: Mon, 19 Jul 2004 09:28:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
Message-ID: <20040719082855.GG3066@lkcl.net>
References: <40FADE92.7060307@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40FADE92.7060307@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

it sounds to me like you almost need to have _two_ contexts.

one method_php_t and the other user_t.

and to be able to make access decisions like this:

	allow method_php_t+user_t bin_t:lnk_file file_read;

meaning "if you have both the method_php_t context AND the user_t
context, then allow reading of symbolic links in /bin".

allowing to have two [or more?] simultaneous contexts might also
help with user directories and stuff, although i have to admit that
i sufficiently don't grok the issues there to be able to anything
other than hint / say "what about this?".

l.

On Sun, Jul 18, 2004 at 04:33:22PM -0400, Joshua Brindle wrote:

> Ok, so I had this seemingly good idea to let apache run interpreted apps 
> (php, perl, whathaveyou) in different domains. To do this I started 
> playing with fastcgi to do the type transition from apache to the 
> interpreters domain (which works well) but that leaves all php scripts 
> in the same domain (php_t) which then can't be isolated from one 
> another. The idea is to have a php domain for each user (method_php_t) 
> and so on. The only way I could think to do this was to use fastcgi's 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
