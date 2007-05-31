Date: Thu, 31 May 2007 15:47:15 -0400
Subject: Re: pipefs issue
From: Chad Sellers <csellers@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        <selinux@tycho.nsa.gov>,
        "Jensen, Curtis R (US SSA)" <curtis.jensen@baesystems.com>
Message-ID: <C2849E83.223F8%csellers@tresys.com>
In-Reply-To: <1180640581.3340.375.camel@moss-spartans.epoch.ncsc.mil>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/31/07 3:43 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Thu, 2007-05-31 at 15:34 -0400, Chad Sellers wrote:
>> On 5/30/07 9:23 PM, "Clarkson, Mike R (US SSA)"
>> <mike.clarkson@baesystems.com> wrote:
<snip> 
>>> Alternatively, can I satisfy the below AVC denial messages without
>>> giving the import_t domain mlsfilereadup privilege? I don't mind giving
>>> the datalabeler_t domain extra privileges like writedown or readup, but
>>> I don't want to give the import_t domain those kind of mls privileges.
>>> 
>> Unfortunately these pipes will be labeled with the creating processes
>> context, so I'm not sure how you could do this. Type Enforcement is flexible
>> enough to let you grant this for a specific instance, but MLS is more of an
>> all-or-nothing model. Perhaps a java wizard has a way to make this not
>> happen. Otherwise you could hack around it by putting a trusted subject in
>> the middle (datalabeler exec's trusted_helper at s1 which is granted
>> mlsfilereadup which launches import).
> 
> Given that he is willing to make datalabeler_t trusted, he could also
> make it a mlstrustedobject, such that attempts to read/write the pipe
> are allowed by the MLS policy unconditionally (only the TE policy would
> then constrain attempts to operate on datalabeler_t, e.g. for signals
> or /proc/pid access).
> 
>> 
Good point. I try to forget about mlstrustedobject.

<snip>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
