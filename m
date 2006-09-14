Subject: Re: ipsec, netlabels, secmark- How about a little usability?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45095E10.2020205@tresys.com>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 10:43:54 -0400
Message-Id: <1158245034.25629.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 09:50 -0400, Joshua Brindle wrote:
> > 1.  By default httpd has to be able to talk to itself in order to do 
> > gracefull shutdown,
> > service httpd graceful.
> >
> > So I end up adding a rule allowing httpd to name_connect to the 
> > httpd_port_t.    But I really only want to allow this for localhost.  
> > IE I don't want to allow my httpd to name_connect to other machines 
> > httpd ports?  I can't do this now.
> >
> you can with secmark can't you?
> iptables -I -p tcp -d localhost -s localhost -i lo --dport 80 -j SECMARK 
> --selctx system_u:object_r:httpd_client_packet_t

IIUC, the mechanism is there, but the necessary integration is not.  How
do we intend to manage local secmark rules, via semanage as with
port/node/netif contexts or via iptables?  How does one express this
kind of goal in refpolicy itself, going beyond just the support for auto
generation of dport-based rules?  Where do we stand on iptables
integration?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
