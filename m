Message-ID: <46896D88.7060504@tresys.com>
Date: Mon, 02 Jul 2007 17:26:32 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, Mark Goldman <mgoldman@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        James Antill <jantill@redhat.com>
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
References: <20070521095414.832619201@tresys.com>	 <1180034401.3930.203.camel@tresys-winxppro>	 <1180108369.6331.18.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com>	 <1180137749.10334.18.camel@localhost.localdomain>	 <4677F1BC.2000201@tresys.com>	 <1182443353.11527.50.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>	 <1182449086.11527.80.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com>	 <1182449898.11527.83.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com>	 <1182450900.11527.88.camel@localhost.localdomain>	 <467AE59E.2050501@tycho.nsa.gov>	 <1182525734.3014.20.camel@localhost.localdomain>	 <467BFF99.9000404@tycho.nsa.gov>	 <1182540624.6599.5.camel@localhost.localdomain>	 <467C3728.6070803@tycho.nsa.gov>  <468904FA.7030102@tresys.com> <1183386217.16330.0.camel@localhost.locald!
 omain>
In-Reply-To: <1183386217.16330.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Mon, 2007-07-02 at 10:00 -0400, Joshua Brindle wrote:
>> Eamon Walsh wrote:
>>> Karl MacMillan wrote:
>>>> On Fri, 2007-06-22 at 12:58 -0400, Eamon Walsh wrote:
>>>>> Karl MacMillan wrote:
>>>>>> On Thu, 2007-06-21 at 16:54 -0400, Eamon Walsh wrote:
>>>>>>
>>>>>>>   I'm not a fan of the Python dependencies.
>>>>>>>
>>>>>> Why?
>>>>> Here's a nice example of RPM hell, courtesy of our Python 
>>>>> dependency.  I got this earlier in the year on one of my machines.
>>>>>
>>>>>
>>>>> # yum -y upgrade
>>>>> --> Running transaction check
>>>>> --> Processing Dependency: gnutls-devel for package: libsoup-devel
>>>>> --> Processing Dependency: python(abi) = 2.4 for package: 
>>>>> audit-libs-python
>>>>> --> Restarting Dependency Resolution with new changes.
>>>>> --> Populating transaction set with selected packages. Please wait.
>>>>> ---> Package gnutls-devel.i386 0:1.4.5-1 set to be updated
>>>>> --> Running transaction check
>>>>> --> Processing Dependency: python(abi) = 2.4 for package: 
>>>>> audit-libs-python
>>>>> --> Finished Dependency Resolution
>>>>> Error: Missing Dependency: python(abi) = 2.4 is needed by package 
>>>>> audit-libs-python
>>>>>
>>>> Rawhide or a release? Was this during the move to 2.5?
>>> It was upgrading across the 2.4/2.5 switch, not rawhide as I recall.  To 
>>> answer James, this was just an example of a problem I ran into; I don't 
>>> have any specific problems with the bindings.
>>>
>>>> Larger issue, though, is that any dependency could cause the same
>>>> problem. I'm not convinced that what was likely a packaging error or yum
>>>> error should prevent us from using the best tools for the job.
>>>>
>>>> Again: I'm not totally against this. I'm just very concerned about the
>>>> potential for problems in this code and the initial implementation
>>>> confirmed all of those concerns. Is it possible to get this code correct
>>>> in C? Sure. Is it likely for it to be correct initially and stay that
>>>> way is the question.
>>>>
>>>> Can I suggest a middle ground? Implement in C (or C++) but use a string
>>>> library.
>>> A library would be great, I'm still depressed about glib's 
>>> abort-on-malloc making it unusable.  ustr was mentioned earlier as a 
>>> possible library that could be used.
>>>
>>>
>> Unfortunately ustr isn't in yum so we'd have to pull code into the lib 
>> itself, which I'd prefer not to.
> 
> Ustr is intended to be pulled into projects - that's why it is a single
> file.
> 

eh?

[root@scarecrow ustr-0.99.3]# ls *.c | wc -l
23

this does not include tests or examples.

>>  Additionally ustr's documentation is a 
>> bit lacking: http://www.and.org/ustr/functions . Stuff like "This 
>> function does nothing." in the docs is a bit disconcerting as well.
>>
> 
> I'm certain James can answer any questions.
> 
> More to the point - what do you think of using some string library?
> 

We are deciding if ustr is the right answer right now, and will report 
our findings later.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
