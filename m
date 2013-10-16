Message-ID: <525EE86F.308@tycho.nsa.gov>
Date: Wed, 16 Oct 2013 15:26:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] Fix referenced before assignment error
References: <20130501202558.GA22742@siphos.be>
In-Reply-To: <20130501202558.GA22742@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/01/2013 04:25 PM, Sven Vermeulen wrote:
> Python warns with
> 
>   UnboundLocalError: local variable 'message' referenced before assignment
> 
> Assigning the first value to message, and append later.
> 
> Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>

Thanks, applied.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
