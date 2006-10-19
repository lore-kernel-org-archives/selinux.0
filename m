Message-ID: <4537A223.6040202@tresys.com>
Date: Thu, 19 Oct 2006 12:04:51 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
CC: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
Subject: Re: SELinux Networking Enhancements
References: <000f01c6f390$3845da60$cc0a010a@tcssec.com>
In-Reply-To: <000f01c6f390$3845da60$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>       
>> Fine.. if MLS doesn't need the flexibility we should consider
>> it a done
>> deal and try to address the flexibility necessary for TE.
>>     
>
> You would have just as many "secpoints" as you currently
> would "secmarks". No difference there. Same level of flexibility
> and scalability. Nothing more, nothing less.
>
>   
 Not if you have to differentiate the level on the interfaces, which was 
my point but it's moot now anyway

> Example:
>
> 1. An outbound connection to port 80 on machine 10.0.0.1
>
> SECMARK:
> -A OUTPUT -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
> SECMARK --selctx system_u:object_r:http_client_packet_t:s2
>
> SECPOINT:
> -A OUTPUT -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
> SECMARK --selctx system_u:object_r:httpd_t:s0
>
> Reason for the change in Type from http_client_packet_t to httpd_t:
>
>   
so what about all the other apps that use port 80 like yum, rss 
aggregators, email clients (when image links are on the body), etc, 
etc.. there are probably hundreds. I don't think you want them all 
sending packets labeled with firefox_t

>> I know this, what I meant was it was never added as a
>> requirement on the
>> old system or the conference call or for a couple weeks after
>> the call,
>> it was added last week as a justification for the new design.
>>     
>
> Forwarding was what started me off several months ago. See:
> https://www.redhat.com/archives/redhat-lspp/2006-June/msg00011.html
> https://www.redhat.com/archives/redhat-lspp/2006-June/msg00012.html
>
>   
Well that explains it.. I'm not on the LSPP list..
>> Which is fine, most of my arguments until now haven't taken it into
>> account because it was new, I have no problem trying to
>> facilitate that
>> in the design but the fact that secpoint covers it doesn't
>> automatically
>> make it good.
>>     
>
> True. And this is why the design has undergone several refinements
> and simplifications (no trasitions for example) and we already were
> looking at another refinement for getpeercon in the past couple days.
>   
Fair enough, I think we are all starting to understand one another much 
better now so hopefully we can get something that works for everyone :)
>> fine, I don't have a problem with the additional checks but the
>> implementation now is strange. With secpeer I start out as
>> Joshua, then
>> change to passed_first_secpoint then passed_second_secpoint
>> and finally
>> passed_plane_gate and the access checks are implemented that way:
>>
>> allow joshua passed_first_secpoint flow_out
>> allow passed_first_secpoint passed_second_secpoint flow_out
>> allow passed_second_secpoint passed_plane_gate flow_out
>>
>> What needs to happen is that I'm Joshua the entire time..
>>
>> allow joshua passed_first_secpoint flow_out
>> allow joshua passed_second_secpoint flow_out
>> allow joshua passed_plane_gate flow_out
>>
>> this maintains me as the subject, which is appropriate.
>>
>>     
>
> This is what I set out to do and couldn't due to constraints.
> My argument has been that you could manage it in the policy
> and Chris seemed to agree (see
> http://marc.theaimsgroup.com/?l=selinux&m=116075228014626&w=2).
> But since this keeps coming up we will try to explore some "bad"
> options and see what happens. Stay tuned on this, but I doubt
> we can get this currently.
>
>   
hrm, ok. So it sounds like we are mostly on the same page but the 
implementation constraints are killing us?
>> Right, I'm aware of this limitation and it's very inconvenient (I
>> believe its what Chris is mainly objecting to)
>>     
>
> Yes. I believe so as well and unfortunately we can't do anything here.
>
>   
ok.
>> I think this seriously limits the usefulness of this. I *must* be able
>> to specify locally who can talk to me from a remote machine.
>>     
>
> Yes and this is indeed what you can acomplish what "remote" domains
> a sock can recv.
>
> If this isn't what you meant, please give me an example and we will try
> again.
>
>   
it may be. What would the rules look like for the client running as 
semanage_t and the server running as pms_t ?
>> That doesn't mean we can't come up with a design that addresses the
>> limitations and still does what we want, hopefully...
>>     
>
> We would need to first understand the specific limitations though
> and these are what I have been trying to understand, but in vain.
>
>   
Ok, good.
>> I know this is frustrating but a better model in the end is better for
>> everyone, please don't give up :( .. I wish I knew more about
>> the actual
>> implementation, it feels like I might be missing some subtle details
>> because of this.
>>
>>     
>
> The biggest shift in the design is coming from here:
> If you want to flow control forwarded traffic, you would necessarily
> have to look at the current secmarking points for the outbound as
> flowcontrol points (which I have sought to characterize as secpoints
> to mark the distinction). And when you do look at the outbound secmarking
> points as flow-control points, you would then want to look at the inbound
> ones as flow-control points as well for consistency. Everything else pretty
> much draws from here.
>   
That is fine, the current design loses a ton of granularity by doing 
this though. Where you say the label gets 'refined' I believe it becomes 
ambiguous. When something is joshua_t and then turns into a generic 
pass_some_secpoint_t you've lost alot of information.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
