Subject: Re: [RFC PATCH 1/3] reference policy: add "context" security class
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
In-Reply-To: <45255B19.8080303@trustedcs.com>
References: <4525496E.4090209@trustedcs.com> <452553BE.3080805@tresys.com>
	 <45255B19.8080303@trustedcs.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 15:47:07 -0400
Message-Id: <1160077627.16462.17.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 14:20 -0500, Darrel Goeddel wrote:
> Joshua Brindle wrote:
> > Darrel Goeddel wrote:
> > 
> >> Define a new security class "context" and its permission "translate" for
> >> use by the context translation daemon.  The bit of policy added to the
> >> setrans_translate_context interface only allows for translation of
> >> domains and file_contexts.  You can see how this is bad if you try to
> >> ls -Z /dev.  I don't have a trick to allow TE access to every type other
> >> than grabbing some "big" attributes, then listing every remaining type.
> >> That obviously does not work in the modular policy model anyway.  Any
> >> ideas on how we could maybe handle that one? (assuming that anyone else
> >> does not want TE restriction on the translations :))  How about a
> >> privilege to use '*' or '~' in typesets...
> >>
> > * and ~ in typesets considered harmful. In addition to the badness of 
> > not actually knowing what you are giving access to they would cause the 
> > avtab to be much bigger (they'd have to be expanded whereas "big" 
> > attributes don't anymore).
> 
> I know, I agreed with the restriction.  I just didn't have a situation
> back then where I only wanted an MLS check :(
> 

well your situation now is clearly wrong :)

> > However, I'm not sure you want to go this route anyway. You are 
> > basically implying that the label of a context is the context itself 
> > (mind bending I know, we did this same thing forever ago with the policy 
> > server). We finally decided that it was much better to explicitly label 
> > then (this was part of the '.' notation). For example the policy server 
> > labeling file might have:
> > 
> > type apache_t   system_u:object_r:apache_root_type_t
> > type apache_t.   system_u:object_r:apache_types_t
> > 
> > then you can give access to everything "under" apache_t in the hierarchy 
> > with just one allow rule but not give access to apache_t. I know this 
> > exact thing won't work for you since you are doing full contexts but you 
> > may want to consider your labeling scheme.
> 
> We could make a "shadow" to every type on the system like foo_t would have
> foo_t.context_type_t, then give all of the *.context_type_t types an attribute
> of context_type, and then do "allow domain context_type:context translate;".
> Anyone mind if I double the number of types?  I'm note really serious here
> in case anyone was wondering ;)
> 

you jest but this is closer to the truth than you think. By implicitly
labeling contexts with themselves you are destroying the concept of a
type (as an equivalence class). The evidence to this is that you are
looking for a way to add rules for every type (clearly you want 1
security equivalence class for them).

> > In the mean time, since the translation permissions is primarily for MLS 
> > anyway you might consider a much more course permission that lets you do 
> > translations in general with the expectation that at some point in the 
> > future you could implement a more fine grained mechanism.
> 
> I take it that you are talking about something like a "self" permission
> (allow domain self:security translate_context; or some such).  The problem there
> is that the actual context must be the target of the check so we can actually
> do the MLS comparison.  If I misunderstood, could you please explain further.
> 

thinking about this... you are right, we don't have a way to just
compare MLS and don't really want one either. An easy solution is to
specify a default label for all types in a config file and to use that
label combined with the level of the target being translated to get an
answer. Something like:

default_context system_u:object_r:all_types_t

requester is sysadm_t:s0, target being translated is foo_t:s1, request
is (shorthanded)

avc_has_perm(::sysadm_t:s0, ::all_types_t:s1, security,
translate_context);

you'll have a TE rule allow sysadm_t (or domain) all_types_t : security
translate_context;

this is essentially poor-mans labeling but it leaves the door open for
more fine grained labeling down the road (particularly as the use of
hierarchical namespaces picks up)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
