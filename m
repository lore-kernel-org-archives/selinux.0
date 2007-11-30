Message-ID: <47503412.20007@manicmethod.com>
Date: Fri, 30 Nov 2007 11:02:26 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, tmiller@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: PATCH: peersid capability support
References: <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com> <1196434083.10720.10.camel@moss-spartans.epoch.ncsc.mil> <47502CED.2030607@manicmethod.com> <200711301044.16726.paul.moore@hp.com>
In-Reply-To: <200711301044.16726.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Friday 30 November 2007 10:31:57 am Joshua Brindle wrote:
>   
>> Equivalence between every module? I don't see how this would possibly
>> work in practice, how would audit2allow know what caps to include when
>> it creates a new module? How would support for new caps come from a
>> policy upgrade when there are local modules present that don't have them?
>>     
>
> I know this is more work both in the code as well as for policy writers, but 
> how about two policy bitmaps for each module: one bitmap (call this bitmap A) 
> indicates the capabilities that the module is knows about (i.e. the policy 
> capabilities that were defined when the module was written) and one bitmap 
> (call this bitmap B) to signal which capabilities should be toggled on?  This 
> way when you load/link/install a series of policy modules you can check to 
> make sure that the union of all the B bitmaps is a subset of the intersection 
> of all the A bitmaps.  If this is not the case you can print an error and 
> refuse to load the module, or load it with the offending capability turned 
> off.
>   

I think this is way too complicated from a user point of view. I don't 
want users to 1) have to know capabilities that have nothing to do with 
their module and 2) disable all caps by not including any in a module 
and potentially hose their system.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
