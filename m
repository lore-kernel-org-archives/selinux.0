Subject: Re: [PATCH 029/155] policycoreutils: fixfiles clean up /var/run and
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <CACLa4puk2gO=aV=oNj-Kmj=eSmYmquX0skKoCxso6o9tWcf_Ng@mail.gmail.com>
References: <4E39B5E6.8000100@redhat.com>
	 <1312469767.20973.53.camel@moss-pluto>
	 <CACLa4ptckXGt6XEqDMnmeZhV3AzVwnL=ktSTtVTFGg+A=Ajcug@mail.gmail.com>
	 <CACLa4puk2gO=aV=oNj-Kmj=eSmYmquX0skKoCxso6o9tWcf_Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Aug 2011 15:33:29 -0400
Message-ID: <1312486409.20973.66.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-08-04 at 13:59 -0400, Eric Paris wrote:
> well I guess [selinuxfs]/initial_contexts/unlabeled works for the
> first part, but how to come up with the lib_t/var_t I don't know....
> more initial sids   :)

chcon --reference=/lib ...
chcon --reference=/var ...

Or:
chcon `matchpathcon /lib` ...


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
