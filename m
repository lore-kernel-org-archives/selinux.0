Message-ID: <5311E855.1070608@quarksecurity.com>
Date: Sat, 01 Mar 2014 09:01:57 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Kernel freak <kernelfreak@gmail.com>
Subject: Re: What is Type Enforcement Model in SELinux?
References: <CAOFt0CQYn+Sku39NOHn4ggX1_8O3y6uvZLtfS1_TQJhirANfNQ@mail.gmail.com>
In-Reply-To: <CAOFt0CQYn+Sku39NOHn4ggX1_8O3y6uvZLtfS1_TQJhirANfNQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "selinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Kernel freak wrote:
> Hello Friends,
>                       I am writing a report and I need to write about TE
> model in SELinux. I searched around the net, but all the articles I read
> beat around the bush and never say like ok, this is TE model for SELinux.
> Can anyone be so kind and please point me out to some links which say
> about TE model in SELinux and if possible an appropriate model. Thank
> you for your time and patience.
>

You are probably having problems finding a succinct description of the 
model because, to my knowledge, there is no complete description as it 
exists today.

I'm sure Stephen will have other suggestions but you can start with the 
old Flask papers:
http://www.cs.utah.edu/flux/fluke/html/flask.html

The type enforcement access matrix model hasn't much changed since then 
but various things related to what that means on a system have (such as 
constraints, network access control, named transitions) evolved over time.
