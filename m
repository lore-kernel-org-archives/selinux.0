Message-ID: <20050615012023.22041.qmail@web51509.mail.yahoo.com>
Date: Tue, 14 Jun 2005 18:20:23 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Question about integration of IPsec with SELinux?
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050614212359.61423.qmail@web31602.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tue, 14 Jun 2005 at 14:23, Casey Schaufler wrote:
>> Do you mean that attributes of receiving process
>> should be sent to the sending machine, which
>> contains the sending process?
>
> You'd have to anticipate what attributes
> of what objects would be needed before you
> could send packets. Beyond current technology.
> 
>> and the access control
>> are made on the sending machine to decide
>> whether the sending process can do interprocess
>> communication with its receiving process?
>
> Again, if you could get the attributes of all
> the receivers onto the sender in a reliable way
> that would be great.

Do you mean that now we can not achieve this with
current technology?


>> Here, the receiving process becomes
>> subject, and the packets which represent its 
>> sending process become objects. 
>
> Well, not quite. In this scenario the sending
> process is still the subject and the receiving
> socket is still the object, as above. The
> fact that the action is taking place on the
> receiving machine is grossly inconvinient
> from an audit perspective, but otherwise
> completely reasonable.

Here, The receiving socket will receive packets sent
by sending process. So, I think that the receiving
socket is initiative, and the packets are passive on
receiving machine.
Then, Would you please tell me why the sending process
is still the subject and the receiving socket is still
the object?

Thank you very much.

Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
