Message-ID: <45A7B31D.6000001@us.ibm.com>
Date: Fri, 12 Jan 2007 10:11:09 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>,
        Klaus Weidner <klaus@atsec.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC] clarifications for -l to newrole.1
References: <45A6A064.2040707@us.ibm.com> <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil> <200701120907.10944.russell@coker.com.au> <1168612577.7993.477.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168612577.7993.477.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-01-12 at 09:07 +1100, Russell Coker wrote:
>> On Friday 12 January 2007 08:02, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> EXAMPLE
>>>>         Changing sensitivity only:
>>>>            # id -Z
>>>>            user:role:type:SystemLow-SystemHigh
>>>>            # newrole -l Unclassified
>>>>            # id -Z
>>>>            user:role:type:Unclassified-SystemHigh
>>> How does SystemLow differ from Unclassified here (in meaning, not just
>>> value)?  If SystemLow is supposed to be a special label for system
>>> objects, then why have users login at that level at all?
>> In the context of the man page I don't think it matters.  The purpose is to
>> clarify an interface that confuses many people.
> 
> I'm concerned about two things:
> - the example being meaningful to the user (what does SystemLow mean
> relative to Unclassified in the user's mind),
> - the actual policy being correct (is it correct for users to login at
> SystemLow and then switch to Unclassified manually, or should they be
> logging in at Unclassified directly and not even allowed to directly
> login at SystemLow).

Currently, in the MLS policy, the default behaviour is to have users 
login at SystemLow. If this is not what you would expect, then we should 
probably change the default levels assumed for users on login.


Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
