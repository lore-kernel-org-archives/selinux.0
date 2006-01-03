Subject: Re: [patch] sereference: add requires to ppp policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: NSA SELinux Mailing-List <SELinux@tycho.nsa.gov>
In-Reply-To: <20051222230743.GB11462@sergelap.austin.ibm.com>
References: <20051222230743.GB11462@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 13:54:38 -0500
Message-Id: <1136314479.29815.39.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-22 at 17:07 -0600, Serge E. Hallyn wrote:
> The following allows ppp to compile as a module on my system, where I
> also have postfix as a module.
> 
> This block also raises the question - is there intended to be a
> difference between an ifdef block and a optional_policy block?  It seems
> to me the intent is probably to use ifdef for actual defines (like
> targeted_policy), and all checks for 'module.te' should be done using
> optional_policy.  Is that the case?

This block of ppp.te is a mistake from converting the module, and needs
to be fixed (also the block right below it).  It needs to be switched to
an optional_policy, and the rules inside it need to be changed to
interface calls.

An ifdef is only used for options that are changed during the build
process, e.g., strict vs. targeted and non-MLS vs. MLS vs. MCS.
Optional_policy is for the old ifdef(`foo.te', where rules are added if
an optional dependency exists, and is implemented using the optional{}
block in the language.  This macro exists because it has the above
behavior for modular policy and for monolithic policies, it falls back
to ifdef(foo.te, since the optional{} does not work for monolithic
policies.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
