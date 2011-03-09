Message-ID: <4D77A496.2040808@tresys.com>
Date: Wed, 09 Mar 2011 11:02:30 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: libselinux version bump past 99
References: <4D76AD1C.8080901@tycho.nsa.gov> <1299675962.4884.7.camel@moss-pluto> <4D77A141.6030908@redhat.com>
In-Reply-To: <4D77A141.6030908@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/09/2011 10:48 AM, Daniel J Walsh wrote:
> On 03/09/2011 08:06 AM, Stephen Smalley wrote:
>> On Tue, 2011-03-08 at 17:26 -0500, Eamon Walsh wrote:
>>> Libselinux has reached version 2.0.99 and I need to push a bug fix, just checking to make sure 2.0.100 is fine and won't cause any problems e.g. with upgrades.
> 
>> Shouldn't be a problem.  However, it does raise the question of when
>> we'll move to 2.1.0.  If the version string consists of
>> major.minor.revision, then possibly we should be incrementing minor and
>> resetting revision whenever there is a new release on
>> userspace.selinuxproject.org?
> 
> Make sense to me.

Sounds good to me.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
