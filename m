Subject: Re: policy development library documentation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Webb <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9f066ee90905060814m138c27a8g16d0e8b6a7b8fc00@mail.gmail.com>
References: <9f066ee90905060814m138c27a8g16d0e8b6a7b8fc00@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 06 May 2009 12:46:10 -0400
Message-Id: <1241628370.27629.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-06 at 11:14 -0400, Mark Webb wrote:
> Greetings,
> 
> I am interested in writing a tool that will open and process a policy
> file.  I was looking around and was unable to determine the proper
> libraries to do this as most of the tools are written in python and
> the libs are written in C, so tracing is a little more difficult.  I
> would like to write this tool in C.
> 
> So my question is; where can I find documentation on the libraries
> that would do this work?  I have the source code for the setools
> project, and do not see much for documentation of the functions.

libsepol contains what you need to load a policy file and manipulate it.
It is unfortunately rather lacking in documentation.

libsepol was originally created by taking the core logic from
checkpolicy and moving it into a library so that it could be re-used by
other programs.  Since that time, a number of the policy analysis tools
have migrated to using libsepol as well, at least for processing the
binary policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
