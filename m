Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Timothy Wood <timothy@hallcomp.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: new file contexts
Date: Fri, 23 Aug 2002 16:17:48 +0200
References: <1030110414.16277.8.camel@phobos>
In-Reply-To: <1030110414.16277.8.camel@phobos>
MIME-Version: 1.0
Message-Id: <20020823141748.6D83438FF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 Aug 2002 15:46, Timothy Wood wrote:
> When you make a new file in the policy/file_contexts/program directory
> do you have to specify the new file somewhere so that it gets compiled
> into the policy or should it just pickup the new file automatically?

Following from Stephen's response, the main problems at the moment regarding 
dependencies are xdm.te depending on xserver.te, sendmail.te conflicting with 
other mail servers (in my policy at least - Steve may have fixed that for the 
NSA policy), and httpadm.te depending on apache.te.  If you encounter any 
other instances of dependencies between .te files then please consider it a 
bug and report it here.

Also the file contexts data is not compiled into the policy, the 
file_contexts/file_contexts file is created out of all appropriate *.fc files 
and is then used by the setfiles program.  I'm not sure whether you 
misunderstood this or whether your email was just unclear, so I want to make 
sure there's no misunderstanding (and also to make it clear for the lurkers).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
