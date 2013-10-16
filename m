Message-ID: <525EE862.70004@tycho.nsa.gov>
Date: Wed, 16 Oct 2013 15:26:26 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] Open stdin as read/write
References: <20130501202632.GB22742@siphos.be>
In-Reply-To: <20130501202632.GB22742@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/01/2013 04:26 PM, Sven Vermeulen wrote:
> As per the discussion on the selinux development mailinglist, the tmux
> application expects the stdin to be writeable. Although perhaps not the most
> proper way, having newrole opening the descriptor in read/write keeps the
> behaviour in line with what applications expect.
> 
> See also http://marc.info/?l=selinux&m=136518126930710&w=2
> 
> Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>

Thanks, applied.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
