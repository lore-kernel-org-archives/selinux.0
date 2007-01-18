Message-ID: <45AFA5F5.2080908@redhat.com>
Date: Thu, 18 Jan 2007 11:53:09 -0500
From: Karl MacMillan <kmacmill@redhat.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: Stephen Smalley <sds@tycho.nsa.gov>, Crispin Cowan <crispin@novell.com>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: Current/Future Plans to Support Stacking LSM Modules
References: <14268.46782.qm@web36613.mail.mud.yahoo.com>
In-Reply-To: <14268.46782.qm@web36613.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> 
>> To the contrary, the LSPP work significantly
>> leverages the work already
>> done to integrate SELinux and makes use of the
>> SELinux interfaces for
>> applications.  It also leverages SELinux TE to
>> address aspects such as
>> MLS overrides.  By doing it within the context of
>> SELinux, it gained the
>> benefit of a unified security model and interface. 
>> Which one doesn't get from LSM.
> 
> There are others who would argue that SELinux
> has abandoned the Linux privilege model and
> thus disrupted the unity of the existing
> security model.
> 

No clue what this means.

> I don't understand why the SELinux crew seems
> so intent on making it difficult to implement
> alternatives. Last year it was "let's ditch LSM".
> Now it's "Everyone hates stacking". Give it a
> rest already.
> 

1) Stacking is possible now, just not arbitrary stacking by an admin.

2) Not having arbitrary stacking in no way limits alternatives. It just 
forces the use of a single alternative at a time or explicit development 
to make alternatives work together.

3) The objections, if you read them, are about whether the correctness 
of arbitrarily stacked modules can be reasonably expected or verified. 
It is not an effort to limit alternatives.

There are real disagreements here, but please stop overstating the 
differences and misconstruing (willfully?) peoples positions.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
