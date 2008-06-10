Message-ID: <484EC1F7.7000506@redhat.com>
Date: Tue, 10 Jun 2008 14:03:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Subject: Re: tracking down execstack & execmem violations
References: <0794F277152EF94AA637E3AECF5CB70FB9EAC8@blums0042.bluelnk.net>	 <1213118122.30576.147.camel@moss-spartans.epoch.ncsc.mil>	 <0794F277152EF94AA637E3AECF5CB70FB9EACE@blums0042.bluelnk.net>	 <1213120159.30576.158.camel@moss-spartans.epoch.ncsc.mil> <7e0fb38c0806101100x452eae80he5192415b9e02868@mail.gmail.com>
In-Reply-To: <7e0fb38c0806101100x452eae80he5192415b9e02868@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Tue, Jun 10, 2008 at 1:49 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>> Java is known to require execmem for runtime code generation.  There is
>> a java_t domain that you can look at as an example.  I think they allow
>> it execstack too, although I'm not as clear as to why that is necessary,
>> possibly for the thread stack allocation.
>>
>> Thread stacks may be allocated with PROT_EXEC if the executable is
>> marked as requiring an executable stack or if it lacks the marking;
>> execstack should tell you the story there.
>>
>> If we can't give execmem w/o giving execstack too, then execstack isn't
>> useful as a separate permission.
> 
> As I recall, which is always a dangerous thing for me todo, execstack
> needs execmem for multithreaded processes because the 'stack' of the
> second thread is just 'memory' from the point of view of the
> permission checks.
> 
> execmem does not need execstack.....
> 
> java probably actually uses an executable stack which is why it needs both.....
I believe it was only one of the java implementations that needed
execstack.  The others did not, but it was either to just allow it for all.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
