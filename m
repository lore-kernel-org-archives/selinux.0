Message-ID: <519E451F.9090003@tycho.nsa.gov>
Date: Thu, 23 May 2013 12:34:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Langland, Blake" <blangland@integrity-apps.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: high to low UDP stream
References: <DA8D339A60101247B36E202899B1C93A8EEA1B@CHUNEX01.integrity-apps.com> <519E44B4.9050400@tycho.nsa.gov>
In-Reply-To: <519E44B4.9050400@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/23/2013 12:32 PM, Stephen Smalley wrote:
> On 05/23/2013 12:20 PM, Langland, Blake wrote:
>> Hello everyone,
>>
>> I am having a hard time figuring out if what I want to do is possible
>> knowing the way that the MLS policy is designed. Basically I am
>> wondering if it is possible to write a module or do some sort of
>> network labeling to allow a UDP stream to be sent from a higher level
>> process on an SELinux machine to a lower classification machine
>> (peer-labeled with netlabel). Here is what I am trying to do:
>>
>> s3 process -----> s2 machine (netlabel)
>>
>> I am aware that this goes against the BLP model of no writes from high
>> to low, but I just wanted to verify if it is possible to make and
>> "exception" of sorts with SELinux. I have tried labeling outgoing
>> packets with SECMARK to s2 but it is still denying the message based
>> on the peer labeling. How do cross domain guards accomplish this since
>> I think some are run on SELinux?
>
> You can generally override the MLS restrictions on a per-domain basis by
> assigning a specific type attribute to the domain.  The specific
> attribute required can be gleaned from the policy/mls constraints, and
> refpolicy usually provides interfaces for doing so, but ultimately it
> just boils down to adding a typeattribute statement that assigns the
> requisite attribute to the domain and then the constraint will be
> satisfied.

BTW, the refpolicy interfaces for assigning these attributes can be 
found in policy/modules/kernel/mls.if file.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
