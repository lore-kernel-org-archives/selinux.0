Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANHGgIi012981
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 12:16:42 -0500 (EST)
Received: from omx1.americas.sgi.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANHGiFP024709
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 17:16:45 GMT
Message-ID: <41A3706C.8080107@sgi.com>
Date: Tue, 23 Nov 2004 12:16:28 -0500
From: Prarit Bhargava <prarit@sgi.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-ia64@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: SELinux & ia64
References: <41A35397.1080001@sgi.com> <20041123161317.GA2775@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041123161317.GA2775@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Matthew,

Thanks for the reply.  In this instance, buf[0] points to a char* -- it 
might not be aligned to u16.

Prarit

Matthew Wilcox wrote:

>On Tue, Nov 23, 2004 at 10:13:27AM -0500, Prarit Bhargava wrote:
>  
>
>>I've tracked this to the usage of le32_to_cpu in 
>>
>>security/selinux/ss/policydb.c
>>
>>The code in question uses:
>>
>>   len = le32_to_cpu(buf[0]);
>>
>>and should be
>>
>>   len = le32_to_cpu(get_unaligned(&buf[0]));
>>    
>>
>
>It would probably be better to find out why buf is unaligned, and see
>if we can make other changes to make it aligned.  If we can't, then I
>recommend a new macro for accessing this element, rather than nest
>the macros like this.  It could look something like:
>
>	len = get_unaligned_le32(buf + 0);
>
>and be implemented perhaps as:
>
>static u32 get_unaligned_le32(u32 *buf)
>{
>	char *bufc = buf;
>	return *bufc | (*(bufc+1) << 8) | (*(bufc+2) << 16) | (*(bufc+3) << 24);
>}
>
>  
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
