Message-ID: <52A631F2.9090508@tycho.nsa.gov>
Date: Mon, 09 Dec 2013 16:11:14 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] Ignore selevel/serange if MLS is disabled
References: <20131209192348.GA3638@siphos.be>
In-Reply-To: <20131209192348.GA3638@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/09/2013 02:23 PM, Sven Vermeulen wrote:
> Currently, the selevel/serange values (which are often set on a default
> 's0' value) are used for ports, users, contexts and logins. This breaks
> non-MLS setups.
> 
> This patch will only call the necessary mls functions if mls is actually
> enabled.
> 
> Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>

Thanks, pushed as policycoreutils 2.2.5.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
