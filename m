Message-ID: <45255D23.9010306@trustedcs.com>
Date: Thu, 05 Oct 2006 14:29:39 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>
Subject: Re: [RFC PATCH 1/3] reference policy: add "context" security class
References: <4525496E.4090209@trustedcs.com> <1160074231.26418.30.camel@sgc>
In-Reply-To: <1160074231.26418.30.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2006-10-05 at 13:05 -0500, Darrel Goeddel wrote:
> 
>>Define a new security class "context" and its permission "translate" for
>>use by the context translation daemon.  The bit of policy added to the
>>setrans_translate_context interface only allows for translation of
>>domains and file_contexts.  You can see how this is bad if you try to
>>ls -Z /dev.
> 
> 
> Yes, as device nodes don't have the file_type attribute, they have
> device_node.
> 
> 
>>I don't have a trick to allow TE access to every type other
>>than grabbing some "big" attributes, then listing every remaining type.
>>That obviously does not work in the modular policy model anyway.  Any
>>ideas on how we could maybe handle that one? (assuming that anyone else
>>does not want TE restriction on the translations :))  How about a
>>privilege to use '*' or '~' in typesets...
> 
> 
> It shouldn't be to hard to build up, we just need things like:
> 
> files_translate_all_contexts()
> corenet_translate_all_contexts()
> fs_translate_all_contexts()
> dev_translate_all_contexts()
> domain_translate_all_contexts()

I'd prefer to keep one interface that gives TE access to translate all contexts.
We really want the translations to happen in general, just not if there is an
MLS violation.  I look at it as more of a allow by default, deny specific type
of check.  I don't see why something would want the ability to translate the MLS
portion of contexts containing "dev" types, but nothing else.  You are just limiting
yourself to the ugly representation of the MLS info.  We actually replace the MLS
portion of the context with "???" if the translation fails in our translation
daemon - rendering the context useless.  No soup for you!  Getting back on track...
It'd be nice if we could say that all types had one of { domain file_type
device_node etc. } so we could just have all of those in the allow rule for the
setrans_translate_context interface.  Any idea how many types are currently not
covered by an attribute (kind of a general classification attribute) like that?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
