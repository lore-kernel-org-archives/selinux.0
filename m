Message-ID: <47BC6DCE.4040203@manicmethod.com>
Date: Wed, 20 Feb 2008 13:13:34 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Subject: Re: How would I go about figuring out if two SELinux MLS Levels	intersect?
References: <47BB5488.1070008@redhat.com>	 <1203528302.9902.226.camel@moss-spartans.epoch.ncsc.mil> <1203528489.9902.230.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1203528489.9902.230.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2008-02-20 at 12:25 -0500, Stephen Smalley wrote:
>   
>> On Tue, 2008-02-19 at 17:13 -0500, Daniel J Walsh wrote:
>>     
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> s2:c0-s2:c0.c10 and s2:c9.c10
>>>
>>>
>>> IE How do I do the arbitration/dominance math in Code?
>>>       
>> (cc'ing the list)
>>
>> You can model it as a permission check between the two contexts, and
>> then write a MLS constraint in policy that requires dominance or
>> whatever relationship you want.  Then it is just an avc_has_perm call.
>> Same thing that we did for permission check in the pam_selinux code to
>> verify that the user's level is within his range.  Or what we talked
>> about for applying a permission check in mcstransd to see if the
>> requestor is allowed to translate the context.  Not sure that ever got
>> implemented in mcstransd though?
>>     
>
> Also, just to note:  the MLS dominance logic already exists within
> libsepol and within the kernel security server.  We just have to expose
> it via an interface.  One way to do that is to express it as a
> permission check, where we already have an interface.  Another way would
> be to introduce a new interface specifically for that purpose.
>   

I strongly disagree with exporting the security server logic in this 
way, that will just encourage people to implement blp in their 
application instead of using the security server interface to do 
permission checking. This is based off what I've seen people trying to 
do, even within the SELinux community, with respect to MLS.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
