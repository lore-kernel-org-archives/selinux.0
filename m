Message-ID: <435E6AD9.2090105@cornell.edu>
Date: Tue, 25 Oct 2005 13:26:49 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] Further users cleanup
References: <435903C2.2050805@cornell.edu>	 <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>	 <4359199A.40303@cornell.edu>	 <1129916287.27663.94.camel@moss-spartans.epoch.ncsc.mil>	 <1130252431.17609.326.camel@moss-spartans.epoch.ncsc.mil>	 <435E56CD.9030003@cornell.edu> <1130259740.17609.345.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1130259740.17609.345.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> I'm confused, the bool_record is supposed to be exported out of sepol... 
>> it's shared with semanage. That could change, based on the current 
>> discussion of sharing records... but I wasn't sure if that's what you 
>> intended.
>>     
>
> hidden_def/hidden_proto isn't about hiding the symbol from users of the
> shared library (that would be done by marking it "hidden", or in the
> libsepol case, by omitting it from the map file).
> hidden_def/hidden_proto creates an internal reference to the symbol for
> use within the library so that intra-library use doesn't require a
> relocation.
>   
You only need this for booleans?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
