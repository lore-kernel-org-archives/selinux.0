From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: checkmodule and MLS/MCS support
Date: Tue, 16 Oct 2007 08:27:01 +1000
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Joshua Brindle" <method@manicmethod.com>,
        "SE-Linux" <selinux@tycho.nsa.gov>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
References: <200710142206.29369.russell@coker.com.au> <1192456623.29203.14.camel@moss-spartans.epoch.ncsc.mil> <1192476945.13098.154.camel@gorn>
In-Reply-To: <1192476945.13098.154.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710160827.06055.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 16 October 2007 05:35, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> If we're willing to say that non-refpolicy
> building is a tiny minority/corner case, then this results in
> practically no gain, since the compiler option is already taken care of
> by the refpolicy build infrastructure.

This discussion started when I cited an example of a new SE Linux user who 
experienced great frustration due to the current mode of operation.

If we have some new users who decide that this is difficult enough that 
selinux=0 is the solution then solving the problem has some real benefits.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
