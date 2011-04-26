Subject: Re: [PATCH 1/3] flex_array: flex_array_prealloc takes a number of
 elements, not an end
From: Eric Paris <eparis@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dave@linux.vnet.ibm.com, steffen.klassert@secunet.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Date: Tue, 26 Apr 2011 15:06:27 -0400
In-Reply-To: <20110426115638.379068b1.akpm@linux-foundation.org>
References: <20110426014531.1740.24077.stgit@paris.rdu.redhat.com>
	 <20110426115638.379068b1.akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1303844791.2101.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-04-26 at 11:56 -0700, Andrew Morton wrote:
> On Mon, 25 Apr 2011 21:45:31 -0400
> Eric Paris <eparis@redhat.com> wrote:
> 
> > Change flex_array_prealloc to take the number of elements for which space
> > should be allocated instead of the last (inclusive) element. Users
> > and documentation are updated accordingly.
> 
> Why?

All three of these patches came from these discussions:
http://marc.info/?t=129552800100005&r=1&w=2
http://marc.info/?t=129646395700004&r=1&w=2
http://marc.info/?t=129708178200007&r=1&w=2

1/3 was changed just because it seemed to be the way the interface was
used

2/3 was changed because the 2.6.38 kernel fails to load certain selinux
policies which worked under 2.6.37 because of this lack of functionality

3/3 was changed just because that's how maybe it should work, although
there are no known users.

I can certainly update 2/3 to better explain the rational but I can't
really do any better on 1/3 and 3/3 other than to just say what the
change is......

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
