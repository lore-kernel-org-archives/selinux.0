Subject: Re: libselinux: Provide new labeling backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: rpcraig <rpcraig@tycho.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <4F831D42.2080208@manicmethod.com>
References: <4F7F4FD5.30108@tycho.ncsc.mil>
	 <4F831D42.2080208@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Apr 2012 13:47:20 -0400
Message-ID: <1333993640.8497.28.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-04-09 at 13:32 -0400, Joshua Brindle wrote:
> rpcraig wrote:
> > I have attached a patch which provides a new labeling backend
> > directed at the Android property service keys.
> 
> Does this apply to the main selinux repo or the android repo? It appears to be 
> the selinux repo but I don't understand what the purpose is since Android uses a 
> different libselinux at runtime.

The patch is for the main selinux repo; this backend is already part of
the Android libselinux.  I suggested that it would be a good idea to add
it to the upstream libselinux at least to avoid a conflict in the future
with the selabel indices, and possibly with an eye toward an eventual
reunification of the two libselinuxes down the road.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
