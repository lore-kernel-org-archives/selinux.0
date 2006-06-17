Message-ID: <4493D0DE.3050805@redhat.com>
Date: Sat, 17 Jun 2006 05:52:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: janak@us.ibm.com, "Timothy R. Chavez" <tinytim@us.ibm.com>,
        sgrubb@redhat.com, tmraz@redhat.com, klaus@atsec.com,
        Valdis.Kletnieks@vt.edu, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: [PATCH] pam_namespace : allow use of X and gdm while polyinstantiating
 /tmp
References: <1150426606.12904.3.camel@localhost.localdomain> <1150480302.19866.1.camel@localhost.localdomain> <4492F9F8.2090508@redhat.com> <200606171030.57042.russell@coker.com.au>
In-Reply-To: <200606171030.57042.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Saturday 17 June 2006 04:35, Daniel J Walsh <dwalsh@redhat.com> wrote:
>   
>> BTW, I talked to the X-Windows developers here and they are looking into
>> getting rid of the /tmp requirement all together for X-Windows.
>>     
>
> What exactly do you mean?  Do you mean moving it somewhere else such 
> as /var/run or do you mean using TCP instead?
>
>   
They are talking about using abstract namespaces. 

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
