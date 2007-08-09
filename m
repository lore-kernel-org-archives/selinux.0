In-Reply-To: <1186693565.6916.753.camel@moss-spartans.epoch.ncsc.mil>
References: <36BDDAA7-7173-42C5-A779-0BD6F1143625@sparta.com> <1186693565.6916.753.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <206A81C3-8FC6-4F59-869F-564344B7BB9A@sparta.com>
Cc: Chris Vance <Christopher.Vance@sparta.com>, selinux@tycho.nsa.gov,
        Matthew Dodd <Matthew.Dodd@sparta.com>
From: Chris Vance <Christopher.Vance@sparta.com>
Subject: Re: xattr and LSM interaction
Date: Thu, 9 Aug 2007 18:34:26 -0400
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Aug 9, 2007, at 5:06 PM, Stephen Smalley wrote:

>> I have a couple questions:
>> 1) Why is the I/O essentially unconditional if the results are
>> intended to be replaced by the value retrieved via the LSM hook.
>
> It allows the hook to look at the on-disk value and make a decision
> about what it wants to do, e.g. replace it, use it, whatever.  At one
> time SELinux looked at it and only replaced it if it didn't already
> match the canonical value, but that turned out to be no more expensive
> than just always replacing.

Thanks for the thorough answers to this and other two pieces.   The  
mailing list archives don't have all the information in any easy-to- 
parse format (though I did try).

This unconditional I/O followed by a discard was the part that  
concerned me the most as we worked on NFSv4 labeling.  I was hoping  
to leverage as much existing code as possible, but at the same time  
it would be nice to avoid the expense of going out to the network to  
retrieve file labels if they were always going to be discarded.

chris.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
